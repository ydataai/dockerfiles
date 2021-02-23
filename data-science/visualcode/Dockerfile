ARG TAG

FROM ydata/laboratories-base_python:${TAG}

LABEL ai.ydata.laboratory.visualcode.version=3.9.0

USER root

RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run --version=3.9.0 && \
    curl -fsSL https://code-server.dev/install.sh | sh

USER ${UID}

EXPOSE 8888

RUN code-server --install-extension ms-python.python --install-extension littlefoxteam.vscode-python-test-adapter

CMD ["bash", "-c", "code-server --auth none --bind-addr 0.0.0.0:8888 --disable-telemetry true"]

