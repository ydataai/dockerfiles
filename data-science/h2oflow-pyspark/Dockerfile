ARG H2OFLOW_VERSION

FROM ydata/h2oflow:${H2OFLOW_VERSION}

COPY --chown=ydata:users conda.txt requirements.txt /tmp/
RUN conda install --quiet --yes --file /tmp/conda.txt \
    && pip --no-cache-dir install -r /tmp/requirements.txt \
    && conda clean --all -f -y \
    && rm -rf /tmp/conda.txt /tmp/requirements.txt
    