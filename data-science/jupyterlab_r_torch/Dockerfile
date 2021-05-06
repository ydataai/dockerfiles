ARG TAG

FROM ydata/jupyterlab_r:${TAG}

ARG TYPE

RUN Rscript -e "install.packages(c('torch', 'torchvision'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "torch::install_torch(type = '${TYPE}', reinstall = TRUE)"
