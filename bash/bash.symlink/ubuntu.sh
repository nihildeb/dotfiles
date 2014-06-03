#!/usr/bin/env bash

ubup() {
  apt-get update
  apt-get install -y git gcc make curl wget nc dnsutils
}

ubdocker_install() {
  wget https://get.docker.io/builds/Linux/x86_64/docker-latest -O docker
  chmod +x docker
  mv docker /usr/local/bin
  pushd $(pwd)
  cd /
  tar xvf ~/.dotfiles/docker/docker_init.tar
  popd
  service docker stop || echo 'docker not running'
  sleep 2
  service docker start
}

ubnsenter_install() {
  #http://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/
  pushd $(pwd)
  cd /tmp
  curl https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz \
    | tar -zxf-
  cd util-linux-2.24
  ./configure --without-ncurses
  make nsenter
  mv nsenter /usr/local/bin
  popd
}


