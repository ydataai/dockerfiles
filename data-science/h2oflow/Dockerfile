FROM ydata/laboratories-base:0.1.0

# Install h2oflow
USER root

# Install basic tools
RUN apt-get -qq update && apt-get -qq -y install default-jre unzip \
    && apt-get autoclean

ENV RELEASE_NAME rel-zermelo/2
ENV H2O_RELEASE h2o-3.32.0.2

RUN curl -o /tmp/h2oflow.zip http://h2o-release.s3.amazonaws.com/h2o/$RELEASE_NAME/$H2O_RELEASE.zip \
    && unzip /tmp/h2oflow.zip -d /tmp \
    && mv /tmp/$H2O_RELEASE /opt/h2oflow \
    && rm -rf /tmp/h2oflow.zip \
    && chown -R ydata:users /opt/h2oflow

USER ydata

# Install dependencies for h2oflow
COPY --chown=ydata:users requirements.txt /tmp/
RUN pip --no-cache-dir install -r /tmp/requirements.txt \
    && rm -rf /tmp/requirements.txt

EXPOSE 8888
CMD ["bash", "-c", "java -jar /opt/h2oflow/h2o.jar -port 8888"]
