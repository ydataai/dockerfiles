ARG TAG

FROM ydata/jupyterlab_python:${TAG}

ARG TYPE

COPY --chown=${USER}:users requirements.txt /tmp/requirements-shared.txt
COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt -r /tmp/requirements-shared.txt

RUN jupyter labextension install jupyterlab_tensorboard --dev-build=False --minimize=False
