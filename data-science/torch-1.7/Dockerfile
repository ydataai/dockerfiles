ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

ARG TYPE

COPY --chown=${USER}:users requirements-${TYPE}.txt /tmp/
RUN pip install pip --no-cache-dir install -r /tmp/requirements-${TYPE}.txt -f https://download.pytorch.org/whl/torch_stable.html

# clean up /tmp
USER root
RUN rm -rf /tmp/*
USER ${UID}
