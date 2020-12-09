ARG TAG
ARG JUPYTERLAB_VERSION

FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}:${TAG}

COPY --chown=ydata:users conda.txt /tmp/

# Update all but JupyterLab and install conda packages
RUN conda update --all --dry-run | \
    grep -Fe '-->' | \
    cut -d' ' -f3 | \
    grep -ve 'jupyterlab' | \
    xargs conda update && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y
