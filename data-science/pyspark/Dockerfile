ARG TAG=""

FROM ydata/jupyterlab-1.2.6-kubeflow:${TAG}

ARG PYSPARK_PACKAGE="pyspark==2.4.5"

RUN pip --no-cache-dir install ${PYSPARK_PACKAGE}