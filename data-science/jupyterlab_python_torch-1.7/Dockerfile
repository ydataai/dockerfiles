ARG TAG

FROM ydata/jupyterlab_python:${TAG}

USER root

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes \
      build-essential \
      unixodbc-dev

USER ${UID}

ARG TYPE

COPY --chown=${USER}:users requirements.txt /tmp/requirements-shared.txt
COPY --chown=${USER}:users ${TYPE}/requirements.txt /tmp/

RUN pip install pip --no-cache-dir install -r /tmp/requirements.txt -r /tmp/requirements-shared.txt -f https://download.pytorch.org/whl/torch_stable.html

USER root

RUN apt-get --purge autoremove --yes build-essential unixodbc-dev && \
    rm -rf /var/lib/apt/lists/* /var/log/dpkg.log /var/cache/apt

USER ${UID}
