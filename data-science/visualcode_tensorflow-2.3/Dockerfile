ARG TAG

FROM ydata/visualcode:${TAG}

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt
