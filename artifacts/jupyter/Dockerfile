FROM ubuntu:jammy-20221130

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -yq dist-upgrade
RUN apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev \
	libffi-dev make wget python3 python3-pip python3-setuptools cmake
RUN apt-get install -y rustc cargo
RUN pip install -U pip setuptools
RUN pip install maturin
RUN apt-get install -y pkg-config
RUN pip install jupyterhub jupyterlab notebook
RUN pip install notebook==6.5.6
RUN jupyter --version
