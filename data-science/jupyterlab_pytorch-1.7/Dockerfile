ARG TAG

FROM ydata/jupyterlab:${TAG}

LABEL JupyterLabVersion=2.2.9

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/requirements.txt

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html
