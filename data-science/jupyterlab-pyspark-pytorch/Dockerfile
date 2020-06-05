ARG JUPYTERLAB_VERSION
ARG PYSPARK_VERSION


FROM ydata/jupyterlab-${JUPYTERLAB_VERSION}_pyspark-${PYSPARK_VERSION}


RUN conda install --quiet --yes -c pytorch pytorch=1.5.0 && conda clean --all -f -y

COPY --chown=ydata:users requirements.txt /tmp/

RUN pip --no-cache-dir install -r /tmp/requirements.txt
