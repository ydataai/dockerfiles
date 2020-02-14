FROM jupyter/all-spark-notebook

USER $NB_USER

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir --upgrade -r /tmp/requirements.txt

RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
