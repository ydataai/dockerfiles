ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab:${JUPYTERLAB_VERSION}

COPY --chown=ydata:users conda.txt requirements.txt /tmp/

RUN conda install --quiet --yes --file /tmp/conda.txt && conda clean --all -f -y

RUN pip --no-cache-dir install -r /tmp/requirements.txt
