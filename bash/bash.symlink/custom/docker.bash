#!/bin/bash
# setting image_prefix will add the user to the image name when building
# i.e. if you are in nginx/ and it contains a Dockerfile
# 'dkb' creates nihildeb/happymoose-nginx
# 'dkb foo' creates nihildeb/happymoose-foo
# if you don't want his feature, just set it to ''
image_prefix=''
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

dkvmup() {
  VBoxManage startvm dock --type headless 
}
dkvmdn() {
  VBoxManage controlvm dock savestate 
}
dkvmssh() {
  ssh -X -p 2222 root@localhost
}
wait_vm() {
  while ! echo "ping" | nc localhost 2222 > /dev/null 2>&1; do
    sleep 1
  done
}

dkps() { ${use_sudo:+ "sudo"} $docker ps ; }
dkpsa() { ${use_sudo:+ "sudo"} $docker ps -a ; }

dkrm() { ${use_sudo:+ "sudo"} $docker rm $1 ; }
dkrmiunnamed() {
  $docker rmi $($docker images | grep '^<none>' | awk '{ print $3 }')
}
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
dkbnocache() {
  if [[ -z "$1" ]]; then
    ${use_sudo:+ "sudo"} $docker build --no-cache -t="$image_prefix${PWD##*/}" . ;
  else
    ${use_sudo:+ "sudo"} $docker build --no-cache -t="$image_prefix$1" . ;
  fi
}
dkip() {
  ${use_sudo:+ "sudo"} $docker inspect -f '{{ .NetworkSettings.IPAddress }}' $1
}
dkpid() {
  ${use_sudo:+ "sudo"} $docker inspect -f '{{ .State.Pid }}' $1
}

dkenter() {
  # lookup container id by name, then inspect because inspect
  # will get confused when there is an image of the same name
  container_id=$($docker ps | awk '/[ \t]'"$1"'[ \t]/ { print $1 }')
  pid=$($docker inspect -f '{{ .State.Pid }}' $container_id)
  nsenter --target $pid --mount --uts --ipc --net --pid
}

dkvi() {
  $EDITOR `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}
dksrc() {
  source `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}

dkmapports() {
  VBoxManage controlvm dock savestate 
  for i in {49000..49900}; do
   VBoxManage modifyvm "dock" --natpf1 "tcp-port$i,tcp,,$i,,$i";
   VBoxManage modifyvm "dock" --natpf1 "udp-port$i,udp,,$i,,$i";
  done
  VBoxManage startvm dock --type headless 
}

dkinstall() {
  apt-get update && apt-get install -y aufs-tools cgroup-lite
  wget https://get.docker.io/builds/Linux/x86_64/docker-latest -O docker
  chmod +x docker
  mv docker /usr/local/bin/docker
  echo 'change settings and configure upstart in /etc/default/docker and /etc/init/docker'
}


