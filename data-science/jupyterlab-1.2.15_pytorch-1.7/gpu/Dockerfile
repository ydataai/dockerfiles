ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

# PyTorch's docs recommend conda over pip
RUN conda install pytorch torchvision torchaudio cudatoolkit=10.1 -c pytorch
