ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab:${TAG}

LABEL JupyterLabVersion=2.2.9

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
