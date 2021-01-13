ARG TAG

FROM ydata/jupyterlab_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
