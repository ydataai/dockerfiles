ARG TAG

FROM ydata/rstudio:${TAG}

USER root

ARG TYPE

RUN Rscript -e "install.packages(c('Rcpp', 'torch', 'torchvision'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "torch::install_torch(type = '${TYPE}', reinstall = TRUE)"

USER ${UID}
