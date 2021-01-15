ARG TAG

FROM ydata/jupyterlab_r:${TAG}

LABEL ai.ydata.laboratory.jupyterlab.version=2.2.9

ARG TYPE

RUN Rscript -e "install.packages(c('torch', 'torchvision'), repos = 'http://cran.us.r-project.org')"
RUN Rscript -e "torch::install_torch(version = '1.7.1', type = '${TYPE}', reinstall = TRUE)"

LABEL org.opencontainers.image.source https://github.com/ydataai/dockerfiles
