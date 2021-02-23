ARG TAG

FROM ydata/visualcode:${TAG}

LABEL ai.ydata.laboratory.visualcode.version=3.9.0

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/requirements.txt

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html
