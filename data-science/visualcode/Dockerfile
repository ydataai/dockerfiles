ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.visualcode.version=3.9.1

# Update and install conda packages
COPY --chown=${USER}:users conda.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

USER root

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=3.9.1

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

# Install pypi dependencies
COPY --chown=${USER}:users requirements-ydata.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements-ydata.txt

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

COPY --chown=ydata:users dask_config.yaml /etc/dask/distributed.yaml

USER ${UID}

EXPOSE 8888

RUN code-server --install-extension ms-python.python
RUN mkdir /home/${USER}/workspace

RUN conda install pylint --quiet --yes && \
    conda clean --all -f -y

ENV URL_BASE_PATH /

CMD ["bash", "-c", "code-server --auth none --bind-addr 0.0.0.0:8888 --disable-telemetry --disable-update-check --home ${URL_BASE_PATH} /home/${USER}/workspace"]
