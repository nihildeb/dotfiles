#!/usr/bin/env bash

#set -o pipefail  # trace ERR through pipes
#set -o errtrace  # trace ERR through 'time command' and other functions
#error() {
    #JOB="$0"              # job name
    #LASTLINE="$1"         # line of error occurrence
    #LASTERR="$2"          # error code
    #echo "ERROR in ${JOB} : line ${LASTLINE} with exit code ${LASTERR}"
    #exit 1
#}
#trap 'error ${LINENO} $?' ERR

# vars
EC2_IP_1='54.86.18.40'
EC2_IP_2='54.86.66.164'
EC2_IP_TEMP='54.86.85.239'
EC2_TESTHOST='192.168.2.13'
EC2_PEM='-i '"${HOME}"'/.ssh/nihildeb.pem'
EC2_USER='root'
DOCKER_SRC="${HOME}/dock"
BASH_DIR="$HOME/.bash"
SECURE_DIR="secure"
SECURE_FILE="secure.tar.gz.gpg"
this_file="$(dirname $BASH_SOURCE)/$(basename $BASH_SOURCE)"

alias tmux='tmux attach || tmux'

ec2u() { ssh $EC2_PEM ubuntu@$EC2_IP_1 ;}
ec2t() { ssh $EC2_USER@$EC2_TESTHOST ;}
ec2() { ssh $EC2_USER@$EC2_IP_1 ;}
ec3() { ssh $EC2_PEM $EC2_USER@$EC2_IP_2 ;}
ec4() { ssh $EC2_PEM $EC2_USER@$EC2_IP_TEMP ;}

# bash <(curl -s https://raw.githubusercontent.com/nihildeb/dotfiles/master/init)
# requires git
# vim +BundleInstall! +qall!

dotvim() {
  $EDITOR ~/.dotfiles
}

shvim() {
  pushd $(pwd)
  cd "$HOME/.bash/"
  $EDITOR
  popd
}

dotsrc() {
  source "$HOME"/.bashrc
}
alias br='dotsrc'

dotp() {
  comment=${1:-'no comment'}
  pushd $(pwd)
  cd ~/.dotfiles/
  git add .
  git commit -v -a -m "$comment"
  git push
  popd
  dotsrc
}

dotl() {
  comment=${1:-'no comment'}
  pushd $(pwd)
  cd ~/.dotfiles/
  git pull
  popd
  $HOME/.bin/dotfiles_update
  dotsrc
}

dotstat() {
  pushd $(pwd)
  cd ~/.dotfiles/
  git status
  popd
}

secon() {
  pushd $(pwd)
  cd ~/.bash/
  tar czvpf - "$SECURE_DIR" | gpg -c --cipher-algo aes256 -o "$SECURE_FILE" && rm -rf "$SECURE_DIR"
  popd
}

secoff() {
  pushd $(pwd)
  cd ~/.bash/
  gpg -d "$SECURE_FILE" | tar xzvf -
  popd
}

authorize() {
  mkdir -p ~/.ssh
  cat ~/.bash/secure/id_rsa.pub >> ~/.ssh/authorized_keys
  chmod 600 ~/.ssh
  chmod 600 ~/.ssh/authorized_keys
}

###########
# Docker
dkpull() {
  pwdir=${PWD}
  if [ ! -d $DOCKER_SRC ]; then
    cd $HOME
    git clone https://github.com/nihildeb/dock.git
  fi
  cd $DOCKER_SRC
  git pull
  cd $pwdir
}
alias dock='ssh -p 2222 root@localhost'

