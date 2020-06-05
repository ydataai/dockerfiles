FROM ydata/base


# Install h2oflow
USER root
RUN curl -o /tmp/h2oflow.zip http://h2o-release.s3.amazonaws.com/h2o/rel-zahradnik/3/h2o-3.30.0.3.zip \
    && unzip /tmp/h2oflow.zip -d /tmp \
    && mv /tmp/h2o-3.30.0.3 /opt/h2oflow \
    && rm -rf /tmp/h2oflow.zip \
    && chown -R ydata:users /opt/h2oflow

USER ydata


# Install dependencies for h2oflow
COPY --chown=ydata:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt


EXPOSE 8888
CMD ["bash", "-c", "java -jar /opt/h2oflow/h2o.jar -port 8888"]
