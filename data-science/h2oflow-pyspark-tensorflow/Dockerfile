ARG H2OFLOW_VERSION
ARG PYSPARK_VERSION


FROM ydata/h2oflow-${H2OFLOW_VERSION}_pyspark-${PYSPARK_VERSION}


COPY --chown=ydata:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt
