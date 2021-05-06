ARG TAG

FROM ydata/jupyterlab_python:${TAG}

ARG TYPE

COPY --chown=${USER}:users requirements.txt /tmp/requirements-shared.txt
COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/
