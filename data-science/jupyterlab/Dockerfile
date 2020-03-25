FROM ubuntu:xenial

ARG USER=ydata

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
    curl -L -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    echo "bfe34e1fa28d6d75a7ad05fd02fa5472275673d5f5621b77380898dee1be15d2 *Miniconda3-latest-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $CONDA_DIR && \
    rm -f Miniconda3-latest-Linux-x86_64.sh && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true
    
# Update CONDA_DIR permissions to allow run as regular user
RUN chown -R ${USER}:users ${CONDA_DIR}

# Force shell to be bash
SHELL ["/bin/bash", "-c"]

# Change to new user
USER ${USER}

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes conda && \
    conda install --quiet --yes python && \
    conda install --quiet --yes pip && \
    conda install --quiet --yes -c conda-forge jupyterlab && \
    conda install --quiet --yes tini && \
    conda install --quiet --yes nodejs=10.13.* && \
    conda clean --all -f -y

RUN pip --no-cache-dir install kubeflow-fairing==0.7.*

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888
ENTRYPOINT [ "tini", "-g", "--" ]
CMD [ "sh", "-c", "jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}" ]