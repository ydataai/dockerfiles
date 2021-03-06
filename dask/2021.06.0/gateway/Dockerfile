ARG FROM
ARG TAG

FROM ${FROM}:${TAG} as miniconda

ARG CONDA_VERSION
ARG CONDA_MD5

RUN useradd -m -U -u 1000 dask \
    && apt-get update \
    && apt-get install -y tini wget bzip2 \
    && wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-$CONDA_VERSION-Linux-x86_64.sh \
    && echo "${CONDA_MD5}  Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" | md5sum -c - \
    && mv Miniconda3-$CONDA_VERSION-Linux-x86_64.sh miniconda.sh \
    && sh ./miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
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
ENV UID 1000
ENV PATH="/opt/conda/bin:$PATH"
WORKDIR /home/dask/

ENTRYPOINT ["tini", "-g", "--"]

FROM miniconda as dependencies

ARG DASK_VERSION
ARG DISTRIBUTED_VERSION

RUN /opt/conda/bin/conda install -c conda-forge --freeze-installed -y \
      python==3.7.10 \
      aiohttp=3.6.2 \
      dask-gateway==0.9.0 \
      lz4==3.1.1 \
      dask==$DASK_VERSION \
      distributed==$DISTRIBUTED_VERSION \
      msgpack-python==1.0.2 \
      numpy==1.18.5 \
      python-blosc==1.9.2 \
    && /opt/conda/bin/conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete

# ** The final image **
FROM dependencies

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

COPY requirements-ydata.txt /tmp/
RUN python -m pip install --no-cache-dir --ignore-installed PyYAML -r /tmp/requirements-ydata.txt

# clean up /tmp
RUN rm -rf /tmp/*

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${UID}

LABEL ai.ydata.dask.version=${DASK_VERSION}
LABEL MAINTAINER="YData Developers"
LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
