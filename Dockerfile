FROM ubuntu:xenial

LABEL maintainer "cfbarbero@gmail.com"

# install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update -q && apt-get install -y apt-transport-https curl zip python-pip groff-base

# AWS CLI 
RUN pip install awscli

# dotnet toolstack for building/testing
RUN sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list' && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && apt update && apt install -y dotnet-dev-1.0.4

WORKDIR /var/app