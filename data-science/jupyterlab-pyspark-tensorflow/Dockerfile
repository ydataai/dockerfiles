ARG BASE_TAG
ARG JUPYTERLAB_VERSION
ARG PYSPARK_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}_pyspark-${PYSPARK_VERSION}:${BASE_TAG}

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends openjdk-8-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER ydata

COPY --chown=ydata:users requirements.txt /tmp/

ARG TF_PACKAGE

RUN echo ${TF_PACKAGE}
RUN conda install --quiet --yes ${TF_PACKAGE} && conda clean --all -f -y

RUN pip --no-cache-dir install -r /tmp/requirements.txt
