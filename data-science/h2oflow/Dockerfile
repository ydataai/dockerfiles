ARG TAG

FROM ydata/laboratories-base:${TAG}

# Install h2oflow
USER root

# Install basic tools
RUN apt-get -qq update && apt-get -qq -y install default-jre unzip \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

ARG RELEASE_NAME
ARG H2O_RELEASE

RUN curl -o /tmp/h2oflow.zip http://h2o-release.s3.amazonaws.com/h2o/$RELEASE_NAME/$H2O_RELEASE.zip \
    && unzip /tmp/h2oflow.zip -d /tmp \
    && mv /tmp/$H2O_RELEASE /opt/h2oflow \
    && rm -rf /tmp/h2oflow.zip \
    && chown -R ydata:users /opt/h2oflow

USER ydata

EXPOSE 8888
CMD ["bash", "-c", "java -jar /opt/h2oflow/h2o.jar -port 8888"]
