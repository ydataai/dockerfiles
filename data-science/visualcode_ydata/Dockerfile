ARG TAG

FROM ydata/visualcode:${TAG}

COPY --chown=ydata:users requirements.txt /tmp/

RUN python -m pip --no-cache-dir install -r /tmp/requirements.txt

RUN python -m pip uninstall pip -y
