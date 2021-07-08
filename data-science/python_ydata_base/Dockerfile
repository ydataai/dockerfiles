ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=3.0.14

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

# Install pypi dependencies
COPY --chown=${USER}:users requirements.txt requirements-ydata.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt

RUN pip --no-cache-dir install -r /tmp/requirements-ydata.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${UID}
