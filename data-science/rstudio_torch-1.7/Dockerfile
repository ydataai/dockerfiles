ARG TAG

FROM ydata/rstudio:${TAG}

USER root

ARG TYPE

RUN Rscript -e "install.packages(c('torch', 'torchvision'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "torch::install_torch(version = '1.7.1', type = '${TYPE}', reinstall = FALSE)"

USER ${UID}

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
