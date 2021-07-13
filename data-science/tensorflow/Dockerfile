ARG FROM
ARG TAG
ARG TYPE
ARG VERSION

FROM ${FROM}:${TAG}

COPY --chown=${USER}:users requirements-${TYPE}-${VERSION}.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements-${TYPE}-${VERSION}.txt
