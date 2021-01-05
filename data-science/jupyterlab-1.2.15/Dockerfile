ARG TAG

FROM ydata/laboratories-base:${TAG}

LABEL JupyterLabVersion=1.2.15

COPY --chown=${USER}:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --dev-build=False --minimize=False

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' NotebookApp.notebook_dirUnicode='/opt/conda/share/jupyter/kernels/ir' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${NB_PREFIX}" ]
