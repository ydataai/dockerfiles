FROM jupyter/all-spark-notebook

USER root
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
      git \
      && \
    apt-get purge && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir --upgrade -r /tmp/requirements.txt

USER ${NB_USER}

RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
