ARG TAG

FROM ydata/jupyterlab_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

ARG TYPE

COPY --chown=${USER}:users requirements.txt /tmp/requirements-shared.txt
COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt -r /tmp/requirements-shared.txt

RUN jupyter labextension install jupyterlab_tensorboard --dev-build=False --minimize=False
