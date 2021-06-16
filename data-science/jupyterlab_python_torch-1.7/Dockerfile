ARG TAG

FROM ydata/jupyterlab_python:${TAG}

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/
RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

