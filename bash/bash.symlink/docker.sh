#!/usr/bin/env bash
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


#####################
# dir based naming
dkimage() {
  if [ -e Dockerfile ]; then
    echo $(basename $(pwd));
  else
    echo 'not a container dir';
  fi
}

dkcontainer() {
  echo $(dkimage)_
}

dkrun() {
  $docker run -t -i $($(pwd)/args.sh) --name=$(dkcontainer) $(dkimage) $@
}

dksrv() {
  $docker run -d $($(pwd)/args.sh) --name=$(dkcontainer) $(dkimage)
}

dkstop() {
  $docker stop $(dkcontainer)
}

dkrm() {
  $docker rm $(dkcontainer)
}

dkrmi() {
  $docker rmi $(dkimage)
}

dkenter() {
  if [[ -n $(which nsenter) ]]; then
    nsenter --target $(dkpid) --mount --uts --ipc --net --pid ;
  else
    echo 'please install nsenter'
    echo 'http://jpetazzo.github.io/2014/03/23/lxc-attach-nsinit-nsenter-docker-0-9/';
  fi
}

dkinfo() {
  echo $($docker inspect $@ $(dkcontainer))
}

dkpid() {
  echo $(dkinfo -f='{{.State.Pid}}')
}

dkunnamed() {
  echo $($docker images | grep '^<none>' | awk '{ print $3 }')
}

##############
# unamed commands

dkps() { ${use_sudo:+ "sudo"} $docker ps ; }
dkpsa() { ${use_sudo:+ "sudo"} $docker ps -a ; }

#dkrm() { ${use_sudo:+ "sudo"} $docker rm $1 ; }
dkrmiunnamed() {
  $docker rmi $($docker images | grep '^<none>' | awk '{ print $3 }')
}
dkrmr() {
  ${use_sudo:+ "sudo"} $docker ps -a -q | xargs --no-run-if-empty ${use_sudo:+ "sudo"} $docker rm
}
dkrma() { dkrmr; }

#dkri() { ${use_sudo:+ "sudo"} $docker run -t -i ${pub_ports:+ "-P"} $@; }
#dkstop() {
  #$docker stop $(basename $(pwd))
#}


dkrd() { ${use_sudo:+ "sudo"} $docker run -d ${pub_ports:+ "-P"} $@; }
dksh() {
  ${use_sudo:+ "sudo"} $docker run -t -i ${pub_ports:+ "-P"} $baseimg /bin/bash
}
dki() { ${use_sudo:+ "sudo"} $docker images ; }
dkirm() { dkrmi $@ ; }
#dkrmi() { ${use_sudo:+ "sudo"} $docker rmi $@ ; }
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
#dkvi() {
  #$EDITOR `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
#}
#dksrc() {
  #source `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
#}

dkmapports() {
  boot2docker stop
  for i in {49000..49900}; do
   VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port$i,tcp,,$i,,$i";
   VBoxManage modifyvm "boot2docker-vm" --natpf1 "udp-port$i,udp,,$i,,$i";
  done
  boot2docker start
}

dkclone() {
  pushd $(pwd)
  cd "$HOME"
  git clone https://github.com/nihildeb/dock
  popd
}


