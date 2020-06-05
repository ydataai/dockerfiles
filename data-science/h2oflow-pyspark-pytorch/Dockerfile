ARG H2OFLOW_VERSION
ARG PYSPARK_VERSION

FROM ydata/h2oflow-${H2OFLOW_VERSION}_pyspark-${PYSPARK_VERSION}

USER ydata

COPY --chown=ydata:users requirements.txt /tmp/
RUN conda install --quiet --yes -c pytorch pytorch=1.5.0 \
    && pip --no-cache-dir install -r /tmp/requirements.txt \
    && conda clean --all -f -y
