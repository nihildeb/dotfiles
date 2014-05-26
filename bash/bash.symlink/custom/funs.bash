# vars
EC2_IP_1='54.86.18.40'
EC2_IP_2='54.86.66.164'
EC2_IP_TEMP='54.86.85.239'
EC2_PEM='-i .ssh/nihildeb.pem'
EC2_USER='ubuntu'

vimdot() {
  $EDITOR ~/.dotfiles
}
vimfun() {
  $EDITOR `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}
srcfun() {
  source `dirname $BASH_SOURCE`/`basename $BASH_SOURCE`
}
ec2() { 
  ssh $EC2_PEM $EC2_USER@$EC2_IP_1
}
ec3() { ssh $EC2_PEM $EC2_USER@$EC2_IP_2 ;}
ec4() { ssh $EC2_PEM $EC2_USER@$EC2_IP_TEMP ;}

alias dock='ssh -p 2222 root@localhost'