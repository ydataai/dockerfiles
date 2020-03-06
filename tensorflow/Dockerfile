ARG TAG=""
ARG JUPYTERLAB_VERSION="1.2.6"

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}-kubeflow:${TAG}

ARG TF_PACKAGE='tensorflow==2.1.*'

RUN pip --no-cache-dir install ${TF_PACKAGE}