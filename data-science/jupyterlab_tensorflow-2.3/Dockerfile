ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

COPY --chown=${USER}:users requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
