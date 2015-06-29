FROM ubuntu:14.04

#If you have a proxy, fill in your proxy ip & port, and uncomment the below 5 entries.
#ENV NO_PROXY=localhost,127.0.0.1,/var/run/docker.sock,*.sock,*.corp
#ENV HTTPS_PROXY=http://<fillin_your_proxy_ip>:<fillin_your_proxy_port>
#ENV HTTP_PROXY=http://<fillin_your_proxy_ip>:<fillin_your_proxy_port>
#ENV https_proxy=http://<fillin_your_proxy_ip>:<fillin_your_proxy_port>
#ENV http_proxy=http://<fillin_your_proxy_ip>:<fillin_your_proxy_port>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

#Runit
RUN apt-get install -y runit 
CMD /usr/sbin/runsvdir-start

#SSHD
RUN apt-get install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    echo 'root:root' |chpasswd
RUN sed -i "s/session.*required.*pam_loginuid.so/#session    required     pam_loginuid.so/" /etc/pam.d/sshd
RUN sed -i "s/PermitRootLogin without-password/#PermitRootLogin without-password/" /etc/ssh/sshd_config

#Utilities
RUN apt-get install -y vim less net-tools inetutils-ping curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common

#required
RUN apt-get install -y build-essential ruby1.9.1 ruby1.9.1-dev
RUN gem install dashing
RUN gem install bundler

#nodejs
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

RUN dashing new dashboard && \
    cd dashboard && \
    bundle

#Add runit services
ADD sv /etc/service 
