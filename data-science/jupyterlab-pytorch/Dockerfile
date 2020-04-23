ARG TAG=""
ARG JUPYTERLAB_VERSION="1.2.6"

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}-kubeflow:${TAG}

ARG PYTORCH_PACKAGE='pytorch==1.4.0'

RUN conda install ${PYTORCH_PACKAGE} -c pytorch