ARG TAG="0.1.0"
ARG JUPYTERLAB_VERSION="1.2.15"

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

COPY --chown=ydata:users requirements.txt /tmp/

RUN pip --no-cache-dir install --use-feature=2020-resolver -r /tmp/requirements.txt
