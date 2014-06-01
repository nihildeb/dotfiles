# vars
EC2_IP_1='54.86.18.40'
EC2_IP_2='54.86.66.164'
EC2_IP_TEMP='54.86.85.239'
EC2_PEM='-i '"${HOME}"'/.ssh/nihildeb.pem'
EC2_USER='ubuntu'
DOCKER_SRC="${HOME}/dock"


# bash <(curl -s https://raw.githubusercontent.com/nihildeb/dotfiles/master/init)
# requires git
# vim +BundleInstall! +qall!

vimdot() {
  $EDITOR ~/.dotfiles
}
pushdot() {
  comment=${1:-'no comment'}
  old=$(pwd)
  cd ~/.dotfiles/
  git add .
  git commit -v -a -m '$comment'
  git push
  cd $old
  srcfun
}
pulldot() {
  comment=${1:-'no comment'}
  old=$(pwd)
  cd ~/.dotfiles/
  git pull
  $HOME/.bin/dotfiles_update
  cd $old
  srcfun
}
statdot() {
  old=$(pwd)
  cd ~/.dotfiles/
  git status
  cd $old
}

vimfun() {
  $EDITOR `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}
srcfun() {
  source `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}

alias tmux='tmux attach || tmux'

ec2() { 
  ssh $EC2_PEM $EC2_USER@$EC2_IP_1
}
ec3() { ssh $EC2_PEM $EC2_USER@$EC2_IP_2 ;}
ec4() { ssh $EC2_PEM $EC2_USER@$EC2_IP_TEMP ;}

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
