ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

ARG TYPE
ARG VERSION

COPY --chown=${USER}:users requirements-${TYPE}-${VERSION}.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements-${TYPE}-${VERSION}.txt

# clean up /tmp
USER root
RUN rm -rf /tmp/*
USER ${UID}
