ARG TAG

FROM ydata/laboratories-base:${TAG}

COPY --chown=ydata:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install git
USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git


# Install pypi dependencies
RUN pip --no-cache-dir install --use-feature=2020-resolver -r /tmp/requirements.txt

# Install typescript
RUN npm install -g typescript

# Install extension
RUN git clone https://github.com/jupytercalpoly/jupyterlab-pkginstaller.git && cd jupyterlab-pkginstaller && \  
    jlpm && jupyter labextension link . && jupyter lab build

# Change user
USER ydata

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888

CMD [ "/bin/bash", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}" ]
