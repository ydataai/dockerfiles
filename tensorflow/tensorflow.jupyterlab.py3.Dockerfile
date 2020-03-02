FROM ydata/jupyterlab-1.2.6-kubeflow:1.0.0

ARG TF_PACKAGE='tensorflow==2.1.*'

RUN pip --no-cache-dir install ${TF_PACKAGE}