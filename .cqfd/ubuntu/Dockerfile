FROM ubuntu:14.04

ENV HOME /home/builder
ENV SSH_AUTH_SOCK /home/builder/.sockets/ssh
ENV DEBIAN_FRONTEND noninteractive

# Buildroot mandatory packages
RUN apt-get update && apt-get install -y --no-install-recommends \
	bc \
	build-essential \
	cpio \
	python2.7 \
	rsync \
	unzip \
	wget \
	libncurses5-dev \
	git \
	ssh \
	subversion \
	asciidoc \
	libssl-dev \
	ca-certificates

WORKDIR /home/builder/src
VOLUME /home/builder/src
