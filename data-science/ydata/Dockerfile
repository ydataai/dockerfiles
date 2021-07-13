ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

COPY --chown=ydata:users requirements.txt requirements-ydata.txt /tmp/
RUN python -m pip --no-cache-dir install -r /tmp/requirements.txt
RUN python -m pip --no-cache-dir install -r /tmp/requirements-ydata.txt

# Weasyprint requirements
USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      libpangocairo-1.0-0

USER ${UID}
