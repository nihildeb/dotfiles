#!/usr/bin/env bash

ubup() {
  apt-get update
  apt-get install -y git gcc make curl wget nc dnsutils
}

ubdocker_install() {
  wget https://get.docker.io/builds/Linux/x86_64/docker-latest -O docker
  chmod +x docker
  mv docker /usr/local/bin
  cd /
  tar xvf ~/.dotfiles/docker/docker_init.tar
  service docker start
}


