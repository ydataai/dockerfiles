ARG TAG

FROM ydata/laboratories-base:${TAG}

LABEL JupyterLabVersion=2.2.9

ARG TYPE

COPY --chown=ydata:users conda.txt ${TYPE}/requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@2.0 @jupyterlab/debugger --dev-build=False --minimize=False

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}" ]
