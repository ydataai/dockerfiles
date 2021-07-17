FROM centos:centos7

RUN yum update -y

RUN yum install -y wget zip unzip tar bind-utils tree mysql nfs-utils

# git
RUN yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm
RUN yum -y install git

# jq
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y jq

# yq
RUN wget https://github.com/mikefarah/yq/releases/download/3.4.1/yq_linux_amd64 -O /usr/bin/yq
RUN chmod +x /usr/bin/yq

# yum development tools (to install make)
RUN yum group install -y "Development Tools"

# python 3.7.9
RUN yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel sqlite-devel
RUN wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz -P /tmp
RUN tar -xzf /tmp/Python-3.7.9.tgz -C /usr/src/
WORKDIR /usr/src/Python-3.7.9/
RUN bash configure --enable-optimizations
RUN make altinstall
WORKDIR /
RUN rm /tmp/Python-3.7.9.tgz
RUN pip3.7 install --upgrade pip

# clean up /tmp
RUN rm -rf /tmp/*

WORKDIR /

# entrypoint
COPY src/scripts/docker-entrypoint.sh /scripts/docker-entrypoint.sh
RUN chmod +x /scripts/docker-entrypoint.sh
ENTRYPOINT [ "/bin/bash", "/scripts/docker-entrypoint.sh" ]
