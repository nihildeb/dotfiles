#!/usr/bin/env bash

# Set the path nginx
export NGINX_PATH='/opt/nginx'

# Don't check mail when opening terminal.
unset MAILCHECK

# redhat/fedora workaround, we're not all GUItards
unset SSH_ASKPASS

# disable flow control if in a terminal (i use ctrl-s in vim)
[ -t 0 ] && stty -ixon

# Change this to your console based IRC client of choice.
export IRC_CLIENT='weechat'

# Set this to the command you use for todo.txt-cli
export TODO="t"

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

[ -f /usr/libexec/java_home ] && export JAVA_HOME=`/usr/libexec/java_home`

if [ $(uname) = "Darwin" ]; then

  # EC2 CLI tools http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/ec2-cli-get-set-up.html
  # OSX specific atm
  export EC2_HOME=/usr/local/ec2/ec2-api-tools-1.6.13.0
  export PATH=$PATH:$EC2_HOME/bin

  #android sdk on osx from homebrew
  export ANDROID_HOME=/usr/local/opt/android-sdk

  # by me: postgres 9.3
  export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin"

  # ZeroC Ice
  export ICE_HOME="/Library/Developer/Ice-3.5.1"
  export PATH="$PATH:/Library/Developer/Ice-3.5.1/bin"

  # ruby/bundler
  export PATH="$PATH:/usr/local/Cellar/ruby193/1.9.3-p545/bin";

else
  echo running linux, no special exports
fi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"
export PATH="./bin:$HOME/.bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/git/man:$MANPATH"

export GOPATH=$HOME/go
export GOROOT=`go env GOROOT`
export PATH=$PATH:$GOROOT/bin
