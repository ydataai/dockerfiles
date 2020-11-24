FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN true

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
ENV USER=ydata
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
ENV MINICONDA_IMAGE Miniconda3-py37_4.9.2-Linux-x86_64.sh
ENV MINICONDA_IMAGE_HASH 3143b1116f2d466d9325c206b7de88f7

RUN cd /tmp && \
    curl -L -O https://repo.anaconda.com/miniconda/$MINICONDA_IMAGE && \
    echo "${MINICONDA_IMAGE_HASH}  ${MINICONDA_IMAGE}" | md5sum -c - && \
    /bin/bash $MINICONDA_IMAGE -b -f -p $CONDA_DIR && \
    rm -f $MINICONDA_IMAGE && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true

# Update CONDA_DIR permissions to allow run as regular user
RUN chown -R ${USER}:users ${CONDA_DIR}

# Force shell to be bash
SHELL ["/bin/bash", "-c"]

# Change to new user
USER ${USER}

COPY --chown=ydata:users conda.txt /tmp/

# Update and install conda packages
RUN conda update --all --quiet --yes && \
    conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

# Setup entrypoint using tini
ENTRYPOINT [ "tini", "-g", "--" ]
