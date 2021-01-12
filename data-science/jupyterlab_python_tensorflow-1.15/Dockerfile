ARG TAG

FROM ydata/jupyterlab:${TAG}

LABEL JupyterLabVersion=1.2.15

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
