FROM centos:7.4.1708

LABEL maintainer="matr1xc0in"

USER root

ENV SHELL=/bin/bash \
    ETH_USER=ethereum \
    ETH_UID=1999 \
    ETH_GID=2999
ENV HOME=/home/$ETH_USER

RUN groupadd -g $ETH_GID $ETH_USER && \
    useradd -u $ETH_UID -g $ETH_GID -d $HOME -ms /bin/bash $ETH_USER && \
    chmod g+w /etc/passwd /etc/group

RUN curl --silent --location https://rpm.nodesource.com/setup_9.x | bash -

RUN yum clean all && rpm --rebuilddb && \
    yum -y install epel-release && \
    yum -y install \
    nc \
    nodejs \
    unzip \
    make \
    gcc \
    gcc-c++ \
    && yum clean all && rm -rf /var/cache/yum && \
    mkdir /tmp/whatever && cd /tmp/whatever && \
    npm install -g bower

COPY . /tmp/whatever/
RUN cd /tmp/whatever; npm install && bower --allow-root install && \
    chown -R $ETH_UID:$ETH_GID $HOME /tmp/whatever && \
    chmod -R g+rwX $HOME /tmp/whatever

WORKDIR /tmp/whatever
USER $ETH_UID

EXPOSE 8000
CMD [ "npm", "start" ]

