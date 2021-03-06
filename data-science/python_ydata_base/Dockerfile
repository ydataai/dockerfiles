ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

# Dask config
COPY --chown=ydata:users dask_config.yaml /etc/dask/distributed.yaml

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt requirements-ydata.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

RUN pip --no-cache-dir install -r /tmp/requirements-ydata.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

# clean up /tmp
RUN rm -rf /tmp/*

USER ${UID}
