ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

USER 1000:1000
ENV UID 1000

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

COPY requirements.txt requirements-ydata.txt /tmp/
RUN python -m pip install --no-cache-dir --ignore-installed PyYAML -r /tmp/requirements.txt
RUN python -m pip install --no-cache-dir --ignore-installed PyYAML -r /tmp/requirements-ydata.txt

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

# clean up /tmp
RUN rm -rf /tmp/*
USER ${UID}
