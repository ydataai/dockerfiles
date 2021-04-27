ARG TAG

FROM ydata/rstudio:${TAG}

USER root

ARG TYPE
ARG VERSION

RUN Rscript -e "install.packages(c('tensorflow', 'reticulate'))"
RUN Rscript -e "tensorflow::install_tensorflow(method = 'conda', envname = 'r-reticulate', version='${VERSION}-${TYPE}')"

USER ${UID}

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
