FROM ydata/jupyterlab-1.2.6-kubeflow:1.0.0

RUN conda install pytorch -c pytorch