ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

USER root

COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

USER ${UID}

COPY --chown=${USER}:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# clean up /tmp
USER root
RUN rm -rf /tmp/*
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
