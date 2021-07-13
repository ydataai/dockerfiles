ARG FROM
ARG TAG

FROM ${FROM}:${TAG}

ARG TYPE
ARG VERSION
COPY --chown=${USER}:users conda.txt /tmp/

# Update and install conda packages
RUN conda install --quiet --yes --file /tmp/conda.txt && \
    conda clean --all -f -y

RUN Rscript -e "install.packages(c('tensorflow'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "tensorflow::install_tensorflow(method = 'conda', envname = 'r-reticulate', version='${VERSION}.*-${TYPE}')"
RUN jupyter lab build --dev-build=False --minimize=False

