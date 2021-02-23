ARG TAG

FROM ydata/visualcode:${TAG}

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip --no-cache-dir install -r /tmp/requirements.txt
