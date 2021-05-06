ARG TAG

FROM ydata/visualcode:${TAG}

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

COPY --chown=ydata:users requirements.txt /tmp/

RUN python -m pip --no-cache-dir install -r /tmp/requirements.txt

RUN python -m pip uninstall pip -y

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${UID}
