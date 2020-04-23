ARG TAG=""
ARG PYSPARK_VERSION=""

FROM ydata/pyspark-${PYSPARK_VERSION}-jupyterlab-1.2.6-kubeflow:${TAG}

ARG TF_PACKAGE='tensorflow==2.1.0'

RUN pip --no-cache-dir install ${TF_PACKAGE}