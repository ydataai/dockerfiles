FROM debian:buster-slim as miniconda

ARG CONDA_VERSION=py38_4.8.3
ARG CONDA_SHA256=879457af6a0bf5b34b48c12de31d4df0ee2f06a8e68768e5758c3293b2daf688

RUN useradd -m -U -u 1000 dask \
    && apt-get update \
    && apt-get install -y tini wget bzip2 \
    && wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh \
    && echo "${CONDA_SHA256}  Miniconda3-$CONDA_VERSION-Linux-x86_64.sh" > miniconda.checksum \
    && if [ $(sha256sum -c miniconda.checksum | awk '{print $2}') != "OK" ] ; then exit 1; fi \
    && mv Miniconda3-$CONDA_VERSION-Linux-x86_64.sh miniconda.sh \
    && sh ./miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh miniconda.checksum \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/dask/.profile \
    && echo "conda activate base" >> /home/dask/.profile \
    && echo "always_yes: true" >> /home/dask/.condarc \
    && echo "changeps1: false" >> /home/dask/.condarc \
    && echo "auto_update_conda: false" >> /home/dask/.condarc \
    && echo "aggressive_update_packages: []" >> /home/dask/.condarc \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && /opt/conda/bin/conda clean -afy \
    && chown -R dask:dask /opt/conda \
    && apt-get autoremove --purge -y wget bzip2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER 1000:1000
ENV PATH="/opt/conda/bin:$PATH"
WORKDIR /home/dask/

ENTRYPOINT ["tini", "-g", "--"]

FROM miniconda as dependencies

ARG DASK_VERSION=2021.06.0
ARG DISTRIBUTED_VERSION=2021.06.0

RUN /opt/conda/bin/conda install -c conda-forge --freeze-installed -y \
      aiohttp=3.6.2 \
      blosc==1.9.2 \
      lz4==3.1.1 \
      dask==$DASK_VERSION \
      distributed==$DISTRIBUTED_VERSION \
      msgpack-python==1.0.2 \
      numpy==1.19.2 \
      pandas==1.1.4 \
    && /opt/conda/bin/conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete

FROM dependencies AS pip

RUN mkdir -p /tmp/install-pip
COPY requirements.txt /tmp/requirements.txt
RUN /opt/conda/bin/pip install -r /tmp/requirements.txt --no-cache-dir --no-deps --prefix /tmp/install-pip

# ** The final image **
FROM dependencies

# Copy over the built dask-gateway
COPY --from=pip /tmp/install-pip /opt/conda/

RUN conda install -c conda-forge --freeze-installed dask-gateway \
  && conda clean -af

LABEL ai.ydata.dask.version=${DASK_VERSION}
LABEL MAINTAINER="YData Developers"
LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
