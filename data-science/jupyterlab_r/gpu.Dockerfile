ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' && \
    apt-get update && apt-get install -yq --no-install-recommends r-base && \
    apt-get remove software-properties-common -yq && apt-get clean

USER ${UID}

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --y --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# clean up /tmp
USER root
RUN rm -rf /tmp/*
USER ${UID}

# Configure container startup
ENV URL_BASE_PATH /
EXPOSE 8888

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager @techrah/text-shortcuts --dev-build=False --minimize=False

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*'  --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${URL_BASE_PATH} --KernelSpecManager.whitelist 'ir'" ]
