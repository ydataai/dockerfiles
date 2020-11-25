ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

COPY --chown=ydata:users requirements.txt /tmp/

RUN pip --no-cache-dir install --use-feature=2020-resolver -r /tmp/requirements.txt
