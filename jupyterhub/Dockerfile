FROM jupyterhub/jupyterhub:0.9.6

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      python3 \
      python3-pip \
      python3-setuptools \
      python3-pycurl \
      sqlite3 \
      && \
    apt-get purge && apt-get clean

ARG USER=jovyan
ARG UID=1000
ARG HOME=/home/jovyan

ENV LANG C.UTF-8

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${UID} \
    --home ${HOME} \
    --force-badname \
    ${USER}

COPY requirements.txt /tmp/requirements.txt
RUN PYCURL_SSL_LIBRARY=openssl pip install --no-cache-dir -r /tmp/requirements.txt

COPY jupyterhub_config.py /srv/jupyterhub_config.py

WORKDIR /srv/jupyterhub

RUN chown ${USER}:${USER} /srv/jupyterhub

EXPOSE 8081

CMD ["jupyterhub", "-f", "/srv/jupyterhub_config.py"]