ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

COPY --chown=${USER}:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# NOTE: Make sure this jupyterlab server extension is the same version as the labextension, 0.23 in this case
RUN jupyter serverextension enable --py jupyterlab_git

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@2 \
    @jupyterlab/debugger@0.3 --dev-build=False --minimize=False

# Integrate NBDIME with git
RUN nbdime config-git --enable --global

# Configure container startup
ENV URL_BASE_PATH /
EXPOSE 8888
CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${URL_BASE_PATH}" ]
