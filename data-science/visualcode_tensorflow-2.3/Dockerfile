ARG TAG

FROM ydata/visualcode:${TAG}

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${UID}

COPY --chown=ydata:users dask_config.yaml /etc/dask/distributed.yaml
