ARG TAG

FROM ydata/laboratories-base:${TAG}

SHELL [ "/bin/bash", "--login", "-c" ]

# Install h2oflow
USER root

# Install basic tools
RUN apt-get -qq update && apt-get -qq -y install \
    libpython3.6-dev \
    default-jre \
    unzip \
    libopenblas-dev \
    pbzip2 \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

ARG RELEASE_NAME
ARG H2O_RELEASE

RUN curl -o /tmp/h2oflow.zip http://h2o-release.s3.amazonaws.com/h2o/$RELEASE_NAME/$H2O_RELEASE.zip \
    && unzip /tmp/h2oflow.zip -d /tmp \
    && mv /tmp/$H2O_RELEASE /opt/h2oflow \
    && rm -rf /tmp/h2oflow.zip \
    && chown -R ${UID}:users /opt/h2oflow

COPY entrypoint.sh /usr/local/bin/
RUN chown ydata:${UID} /usr/local/bin/entrypoint.sh && chmod u+x /usr/local/bin/entrypoint.sh

USER ${UID}

EXPOSE 8888

RUN conda init bash

RUN echo ". $CONDA_DIR/etc/profile.d/conda.sh" >> ~/.profile

RUN conda create -n h2o4gpuenv -c h2oai -c conda-forge -c rapidsai h2o4gpu-cuda10

RUN conda activate h2o4gpuenv

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD ["bash", "-c", "java -jar /opt/h2oflow/h2o.jar -port 8888"]
