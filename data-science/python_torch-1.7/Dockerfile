ARG TAG

FROM ydata/jupyterlab_python:${TAG}
FROM ydata/python_ydata_base:${TAG}

ARG TYPE

COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/
RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -f https://download.pytorch.org/whl/torch_stable.html

