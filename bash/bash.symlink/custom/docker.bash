#!/bin/bash
export DOCKER_HOST=tcp://localhost:4243
alias dkb2='boot2docker'
# setting image_prefix will add the user to the image name when building
# i.e. if you are in nginx/ and it contains a Dockerfile
# 'dkb' creates nihildeb/happymoose-nginx
# 'dkb foo' creates nihildeb/happymoose-foo
# if you don't want his feature, just set it to ''
image_prefix='nihildeb/'
# default base image for an interactive shell
baseimg='ubuntu:14.04'
# always use -P when running an image
# -P, --publish-all=false: Publish all exposed ports to the host interfaces
pub_ports=false
# docker command just for grins
#docker='docker -H='$DOCKER_HOST
docker='docker'
# use sudo if not root
use_sudo=''
#if [[ $EUID -ne 0 ]]; then use_sudo=true; fi

dkls() { ${use_sudo:+ "sudo"} $docker ps -a -q ; }
dkll() { ${use_sudo:+ "sudo"} $docker ps -a ; }

dkrm() { ${use_sudo:+ "sudo"} $docker rm $1 ; }
dkrmr() {
  ${use_sudo:+ "sudo"} $docker ps -a -q --no-trunc | xargs ${use_sudo:+ "sudo"} $docker rm
}
dkrma() { dkrmr; }

dkri() { ${use_sudo:+ "sudo"} $docker run -t -i ${pub_ports:+ "-P"} $@; }
dkrd() { ${use_sudo:+ "sudo"} $docker run -d ${pub_ports:+ "-P"} $@; }
dksh() {
  ${use_sudo:+ "sudo"} $docker run -t -i ${pub_ports:+ "-P"} $baseimg /bin/bash
}
dki() { ${use_sudo:+ "sudo"} $docker images ; }
dkirm() { dkrmi $@ ; }
dkrmi() { ${use_sudo:+ "sudo"} $docker rmi $@ ; }
dkb() {
  if [[ -z "$1" ]]; then
    ${use_sudo:+ "sudo"} $docker build -t="$image_prefix${PWD##*/}" . ;
  else
    ${use_sudo:+ "sudo"} $docker build -t="$image_prefix$1" . ;
  fi
}
dkip() {
  ${use_sudo:+ "sudo"} $docker inspect -f '{{ .NetworkSettings.IPAddress }}' $1
}
dkvi() {
  $EDITOR `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}
dksrc() {
  source `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}

dkmapports() {
  boot2docker stop
  for i in {49000..49900}; do
   VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
   VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
  done
  boot2docker start
}
