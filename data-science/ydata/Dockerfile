ARG TAG

FROM ydata/jupyterlab_python:${TAG}

COPY --chown=ydata:users requirements.txt /tmp/

RUN python -m pip --no-cache-dir install -r /tmp/requirements.txt

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN python -m pip uninstall pip -y
