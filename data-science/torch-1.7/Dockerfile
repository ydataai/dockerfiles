ARG FROM
ARG TAG
ARG TYPE

FROM ${FROM}:${TAG}

COPY --chown=${USER}:users requirements-${TYPE}.txt /tmp/
RUN pip install pip --no-cache-dir install -r /tmp/requirements-${TYPE}.txt -f https://download.pytorch.org/whl/torch_stable.html
