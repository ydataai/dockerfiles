FROM ydata/base:latest

USER root

RUN apt-get -qq update \
  && apt-get -qq -y install \
    gcc \
    libhdf5-dev \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${USER}

COPY --chown=ydata:users conda.txt requirements.txt /tmp/

# Install conda packages
RUN conda install --quiet -y --file /tmp/conda.txt && \
    conda clean --all -f -y && \
    rm -rf /tmp/conda.txt


# Install pypi dependencies
RUN pip --no-cache-dir install -r /tmp/requirements.txt && \
  rm -rf /tmp/requirements.txt

# Enable kale extension
RUN jupyter labextension install kubeflow-kale-launcher

COPY pandas-profiling-2.9.1.tar.gz /tmp/
RUN pip install /tmp/pandas-profiling-2.9.1.tar.gz

COPY ydata-0.0.12* /tmp/
RUN pip install /tmp/ydata-0.0.12.tar.gz

# Configure container startup
ENV NB_PREFIX /
EXPOSE 8888
ENTRYPOINT [ "tini", "-g", "--" ]
CMD jupyter lab --notebook-dir=/home/${USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}
