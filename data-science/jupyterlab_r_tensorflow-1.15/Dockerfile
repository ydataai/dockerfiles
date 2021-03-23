ARG TAG

FROM ydata/jupyterlab_r:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

ARG TYPE
COPY --chown=${USER}:users ${TYPE}/requirements.txt conda.txt /tmp/

# Update and install conda packages
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

RUN pip --no-cache-dir install -r /tmp/requirements.txt

RUN Rscript -e "install.packages(c('tensorflow'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "tensorflow::install_tensorflow(method = 'conda', envname = 'r-reticulate', version='1.15.*-${TYPE}')"
RUN jupyter lab build --dev-build=False --minimize=False

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles

