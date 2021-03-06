ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
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
