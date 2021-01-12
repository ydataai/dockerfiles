ARG TAG

FROM ydata/jupyterlab_python:${TAG}

LABEL JupyterLabVersion=1.2.15

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/requirements.txt

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html
