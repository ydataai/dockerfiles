ARG CUDA=10.1

FROM nvidia/cuda:${CUDA}-base-ubuntu18.04

ARG CUDA
ARG CUDNN=7=7.6.4.38-1+cuda10.1
ARG LIBNVINFER=6=6.0.1-1+cuda10.1

# Support for string substituion
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-command-line-tools-${CUDA/./-} \
        libcublas10=10.2.1.243-1 \
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
        libnvinfer-plugin${LIBNVINFER} \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

# Link the libcuda stub to the location where some tools are searching for it
# Create configurations for dynamic linker and reconfigure it
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf \
    && echo "/usr/local/cuda/extras/CUPTI/lib64" > /etc/ld.so.conf.d/cupti.conf \
    && ldconfig

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
