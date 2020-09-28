ARG JUPYTERLAB_VERSION
ARG PYSPARK_VERSION


FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}_pyspark-${PYSPARK_VERSION}


COPY --chown=ydata:users requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt

USER root
RUN apt-get -qq update \
  && apt-get -qq -y install \
    curl \
    sudo \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt \
  && echo "ydata     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER ydata
