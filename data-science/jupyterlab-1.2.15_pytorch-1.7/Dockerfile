ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

ARG TYPE

COPY --chown=${USER}:users conda.txt /tmp/
COPY --chown=${USER}:users ${TYPE}/conda.txt /tmp/conda-${TYPE}.txt

RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda install --quiet --yes --file /tmp/conda-${TYPE}.txt && \
    conda clean --all -f -y
