ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

COPY --chown=${USER}:users conda.txt /tmp/

# Update all but JupyterLab and install conda packages
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y
