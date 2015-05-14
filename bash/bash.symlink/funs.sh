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
RPI_IP_1='192.168.2.2'
STUDIO_IP='192.168.2.3'
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

rpi() { ssh -Y pi@$RPI_IP_1 ;}
studio() { ssh -Y $STUDIO_IP ;}
pis() { rsync -avz ~/sync/pd/ -e ssh $RPI_IP_2:/home/nihildeb/pd ;}
ec2() { ssh $EC2_PEM ubuntu@$EC2_IP_1 ;}
ec2t() { ssh $EC2_USER@$EC2_TESTHOST ;}
ec2old() { ssh $EC2_USER@$EC2_IP_1 ;}
ec3() { ssh $EC2_PEM $EC2_USER@$EC2_IP_2 ;}
ec4() { ssh $EC2_PEM $EC2_USER@$EC2_IP_TEMP ;}

# bash <(curl -s https://raw.githubusercontent.com/nihildeb/dotfiles/master/init)
# requires git
# vim +BundleInstall! +qall!

dotvim() {
  $EDITOR ~/.dotfiles
}

funvim() {
  $EDITOR $HOME/.bash/funs.sh
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
  chmod 700 ~/.ssh
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

install_key() {
  cat "$HOME/.ssh/id_rsa.pub" | ssh $EC2_PEM $EC2_USER@$EC2_IP_1 "gitreceive upload-key nihildeb"
}

srvstatus() {
  local digcommand='dig +short '
  source $HOME/.bash/domains.sh
  echo " -- checking pdns ip1..."
  for domain in ${cust1_domains[@]}; do
    if [[ $($digcommand $EC2_IP_1 SOA $domain) =~ "$EC2_IP_1" ]]; then
      echo OK $domain;
    else
      echo NOK $domain;
    fi
  done

  echo " -- checking pdns ip1..."
  for domain in ${cust1_domains[@]}; do
    if [[ $($digcommand $EC2_IP_2 SOA $domain) =~ "$EC2_IP_2" ]]; then
      echo OK $domain;
    else
      echo NOK $domain;
    fi
  done

  # curl -s -I http://www.happymoose.com |head -n 1 |awk '{print $2}'
  echo " -- checking www by ip..."
  echo $(curltest $EC2_IP_1) $EC2_IP_1
  echo $(curltest $EC2_IP_2) $EC2_IP_2

  echo " -- checking www by domain..."
  for domain in ${cust1_domains[@]}; do
    echo $(curltest $domain) $domain
  done

  echo " -- checking redmine by domain..."
  for domain in ${cust1_domains[@]}; do
    echo $(curltest project.$domain) project.$domain
  done

  echo " -- checking smtp ports..."
  if [[ $(nc -z -w1 $EC2_IP_1 25) ]]; then
    echo OK $EC2_IP_1 25;
  else
    echo NOK $EC2_IP_1 25;
  fi
  if [[ $(nc -z -w1 $EC2_IP_2 25) ]]; then
    echo OK $EC2_IP_2 25;
  else
    echo NOK $EC2_IP_2 25;
  fi

}

# usage: curltest url 
# echos reponse code
curltest() {
  echo $(curl -s -I $1 |head -n 1 |awk '{print $2}')
}

pgtunnel() {
  ssh -2 -N -f -L 5432:localhost:5432 root@ipsaw.com
}

flacify() {
  # convert .wav to flac recursively
  for i in *.wav ; do
    echo convert "$i" to $(basename "$i").flac
    #flac -8 "$i" -o $(basename "$i").flac
  done
}
