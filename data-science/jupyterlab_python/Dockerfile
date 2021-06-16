ARG TAG

FROM ydata/laboratories-base_python:0.18.4-cpu

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt requirements-ydata.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

RUN pip --no-cache-dir install -r /tmp/requirements-ydata.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

COPY --chown=ydata:users dask_config.yaml /etc/dask/distributed.yaml

USER ${UID}

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --dev-build=False --minimize=False

# Integrate NBDIME with git
RUN nbdime config-git --enable --global

# Configure elyra runtime-images
COPY --chown=ydata:users elyra-runtime-images/*.json /opt/conda/share/jupyter/metadata/runtime-images/

# Configure container startup
ENV URL_BASE_PATH /
EXPOSE 8888
ENTRYPOINT [ "/etc/entrypoint.sh" ]
CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${URL_BASE_PATH}" ]
