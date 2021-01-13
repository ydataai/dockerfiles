ARG TAG

FROM ydata/rstudio:${TAG}

ARG TYPE

USER root

RUN Rscript -e "install.packages(c('r-reticulate', 'tensorflow'))"
RUN Rscript -e "tensorflow::install_tensorflow(method = 'conda', envname = 'r-reticulate', version='1.15.0-${TYPE}')"

USER ydata

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
