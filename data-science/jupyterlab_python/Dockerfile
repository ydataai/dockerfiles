ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager --dev-build=False --minimize=False

# Integrate NBDIME with git
RUN nbdime config-git --enable --global

# Configure container startup
ENV URL_BASE_PATH /
EXPOSE 8888
CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.terminals_enabled=False --NotebookApp.base_url=${URL_BASE_PATH}" ]
