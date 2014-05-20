#!/bin/bash

#alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
#drm() { docker rm $(docker ps -q -a); }
#dri() { docker rmi $(docker images -q); }
#alias dkrd="docker run -d -P"
#alias dkri="docker run -t -i -P"
#alias dksh="docker run -t -i ubuntu /bin/bash"

#docker ps -a -q | xargs docker rm

# username will be prepended on images and such i.e. happymoose/sshd
username='happymoose'

# use sudo if not root
docker_command=''
function set_docker_command() {
  if [[ $EUID -ne 0 ]]; then
    eval "$docker_command='docker'"
  else
    eval "$docker_command='sudo docker'"
  fi
}

all_ids=''
function set_all_ids() {
  set_docker_command
  eval "$all_ids='$docker_command ps -a -q'"
  all_ids=$(docker_command) ps -a -q
}

dkls() {
  set_all_ids
  echo $all_ids
}

# list all docker IPs
#dkip() {

#}
