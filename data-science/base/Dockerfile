FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

# Install basic tools
RUN apt-get -qq update \
    && apt-get -qq -y install \
        curl \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt


# ## Install and setup miniconda3
ENV CONDA_DIR /opt/conda
ENV PATH ${CONDA_DIR}/bin:$PATH
RUN curl -sSL https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.3-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && echo "751786b92c00b1aeae3f017b781018df  /tmp/miniconda.sh" | md5sum -c - \
    && bash /tmp/miniconda.sh -bfp ${CONDA_DIR} \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update -y conda \
    && conda update --all -y \
    && conda clean --all -y \
    && echo /opt/conda/lib > /etc/ld.so.conf.d/conda.conf \
    && ldconfig


# Setup user environment
# C ate USER user with UID=1000 and in the 'users' group
# but allow for non-initial launches of the notebook to have
# $HOME provided by the contents of a PV
ENV USER ydata
ENV UID 1000
RUN useradd -m -s /bin/bash -N -u ${UID} ${USER} \
    && chown -R ${USER}:users /opt/conda
USER ${USER}
WORKDIR /home/${USER}


# Install Pypi and conda packages
COPY --chown=ydata:users conda.txt /tmp
RUN conda install --quiet --yes --file /tmp/conda.txt \
    && conda clean --all -f -y \
    && rm -rf /tmp/conda.txt


# Setup entrypoint using tini
ENTRYPOINT [ "tini", "-g", "--" ]
