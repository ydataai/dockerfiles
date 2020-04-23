FROM ubuntu:xenial

ENV USER=ydata

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -yq --no-install-recommends \
    ca-certificates \
    curl \
    locales \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Prepare for user environment
ENV USER ${USER}
ENV UID 1000

# Create USER user with UID=1000 and in the 'users' group
# but allow for non-initial launches of the notebook to have
# $HOME provided by the contents of a PV
RUN useradd -m -s /bin/bash -N -u ${UID} ${USER} \
    && chown -R ${USER}:users /usr/local/bin

## Install and setup miniconda3
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN cd /tmp && \
    curl -L -O https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.2-Linux-x86_64.sh && \
    echo "87e77f097f6ebb5127c77662dfc3165e  Miniconda3-py37_4.8.2-Linux-x86_64.sh" | md5sum -c - && \
    /bin/bash Miniconda3-py37_4.8.2-Linux-x86_64.sh -b -f -p $CONDA_DIR && \
    rm -f Miniconda3-py37_4.8.2-Linux-x86_64.sh && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true
    
# Update CONDA_DIR permissions to allow run as regular user
RUN chown -R ${USER}:users ${CONDA_DIR}

# Force shell to be bash
SHELL ["/bin/bash", "-c"]

# Change to new user
USER ${USER}

COPY --chown=ydata:users conda.txt requirements.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888
ENTRYPOINT [ "tini", "-g", "--" ]
CMD [ "sh", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}" ]