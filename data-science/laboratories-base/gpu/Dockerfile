ARG FROM

FROM $FROM

# Support for string substituion
SHELL ["/bin/bash", "-c"]

ARG MINICONDA_IMAGE
ARG MINICONDA_IMAGE_HASH
ARG CUDA
ARG CUDNN
ARG LIBNVINFER
ARG LIBCUBLAS

ENV DEBIAN_FRONTEND noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -yq --no-install-recommends \
    ca-certificates \
    curl \
    locales \
    cuda-command-line-tools-${CUDA/./-} \
    libcublas${LIBCUBLAS} \
    cuda-nvrtc-${CUDA/./-} \
    cuda-cufft-${CUDA/./-} \
    cuda-curand-${CUDA/./-} \
    cuda-cusolver-${CUDA/./-} \
    cuda-cusparse-${CUDA/./-} \
    libcudnn${CUDNN} \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    pkg-config \
    libnvinfer${LIBNVINFER} \
    libnvinfer-plugin${LIBNVINFER} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

# Link the libcuda stub to the location where some tools are searching for it
# Create configurations for dynamic linker and reconfigure it
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf \
    && echo "/usr/local/cuda/extras/CUPTI/lib64" > /etc/ld.so.conf.d/cupti.conf \
    && ldconfig

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Prepare for user environment
ENV USER ydata
ENV UID 1000

# Create USER user with UID=1000 and in the 'users' group
# but allow for non-initial launches of the notebook to have
# $HOME provided by the contents of a PV
RUN useradd -m -s /bin/bash -N -u ${UID} ${USER} \
    && chown -R ${UID}:users /usr/local/bin

## Install and setup miniconda3
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN cd /tmp && \
    curl -L -O https://repo.anaconda.com/miniconda/$MINICONDA_IMAGE && \
    echo "${MINICONDA_IMAGE_HASH}  ${MINICONDA_IMAGE}" | md5sum -c - && \
    /bin/bash $MINICONDA_IMAGE -b -f -p $CONDA_DIR && \
    rm -f $MINICONDA_IMAGE && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true

# Update CONDA_DIR permissions to allow run as regular user
RUN chown -R ${UID}:users ${CONDA_DIR}

# Change to new user
USER ${UID}

COPY --chown=${UID}:users conda.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Setup entrypoint using tini
ENTRYPOINT [ "tini", "-g", "--" ]
