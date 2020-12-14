ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

ARG TYPE

COPY --chown=${USER}:users conda.txt /tmp/

RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y
