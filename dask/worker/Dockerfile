ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

USER 1000:1000
ENV UID 1000

RUN apt update -y && apt install build-essential unixodbc-dev -y

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir --ignore-installed PyYAML -r /tmp/requirements.txt

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

# clean up /tmp
USER root
RUN rm -rf /tmp/*
USER ${UID}
