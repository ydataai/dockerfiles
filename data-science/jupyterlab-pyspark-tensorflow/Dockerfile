ARG JUPYTERLAB_VERSION
ARG PYSPARK_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}_pyspark-${PYSPARK_VERSION}

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends openjdk-8-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER ydata

COPY --chown=ydata:users requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt
