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


