ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt
