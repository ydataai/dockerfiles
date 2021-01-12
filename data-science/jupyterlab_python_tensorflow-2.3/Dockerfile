ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab:${TAG}

LABEL JupyterLabVersion=1.2.15

COPY --chown=${USER}:users requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
