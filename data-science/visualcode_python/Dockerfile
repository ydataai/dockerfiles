ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

LABEL ai.ydata.laboratory.visualcode.version=3.9.1

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=3.9.

USER ${UID}

EXPOSE 8888

RUN code-server --install-extension ms-python.python
RUN mkdir /home/${USER}/workspace

RUN conda install pylint --quiet --yes && \
    conda clean --all -f -y

ENV URL_BASE_PATH /

CMD ["bash", "-c", "code-server --auth none --bind-addr 0.0.0.0:8888 --disable-telemetry --disable-update-check --home ${URL_BASE_PATH} /home/${USER}/workspace"]
