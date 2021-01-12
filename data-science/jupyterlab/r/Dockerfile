ARG TAG

FROM ydata/laboratories-base_r:${TAG}

LABEL JupyterLabVersion=2.2.9

COPY --chown=${USER}:users conda.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager @techrah/text-shortcuts --dev-build=False --minimize=False

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.terminals_enabled=False --NotebookApp.password='' --NotebookApp.allow_origin='*'  --NotebookApp.base_url=${NB_PREFIX} --KernelSpecManager.whitelist 'ir'" ]
