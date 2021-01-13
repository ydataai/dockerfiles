ARG TAG

FROM ydata/laboratories-base-r:${TAG}

USER root

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    libapparmor1 \
    libclang-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    r-base \
    make \
    sudo \
    build-essential \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /dev/stdout /var/log/syslog \
    && curl https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1093-amd64.deb  \
    -o /tmp/rstudio.deb \
    && apt-get -y install /tmp/rstudio.deb \
    && rm -rf /tmp/rstudio.deb

RUN Rscript -e "install.packages(c('Rcpp', 'base64enc', 'digest', 'evaluate', 'glue', 'highr', 'htmltools', 'jsonlite', 'knitr', 'magrittr', 'markdown', 'mime', 'rmarkdown', 'rprojroot', 'stringi', 'stringr', 'tinytex', 'xfun', 'yaml'))"

USER ydata
EXPOSE 8787

ENTRYPOINT ["/usr/lib/rstudio-server/bin/rserver"]
CMD ["--server-daemonize=0", "--server-app-armor-enabled=0", "--auth-none=1"]
