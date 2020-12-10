ARG TAG

FROM ydata/laboratories-base:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

COPY --chown=${USER}:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# Install extension
RUN git clone https://github.com/jupytercalpoly/jupyterlab-pkginstaller.git /tmp/jupyterlab-pkginstaller && cd /tmp/jupyterlab-pkginstaller && \
    jlpm && jupyter labextension link . && jupyter lab build

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

# NOTE: Make sure this jupyterlab server extension is the same version as the labextension, 0.23 in this case
RUN jupyter serverextension enable --py jupyterlab_git

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@2 \
    @jupyterlab/git@0.23 \
    @jupyterlab/debugger@0.3 --dev-build=False --minimize=False

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${NB_PREFIX}" ]
