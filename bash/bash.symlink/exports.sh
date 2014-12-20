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
  export ANDROID_SDK=/usr/local/Cellar/android-sdk/23.0.2
  export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/23.0.2
  export ANDROID_NDK=/usr/local/Cellar/android-ndk-r9d/r9d
  export NDK_ROOT=/usr/local/Cellar/android-ndk-r9d/r9d
  export COCOS2DX_ROOT=/usr/local/cocos2d-x-3.3rc0
  export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools
  export PATH=$PATH:$COCOS2DX_ROOT/tools/cocos2d-console/bin

  # by me: postgres 9.3
  export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin"

  # ZeroC Ice
  #export ICE_HOME="/Library/Developer/Ice-3.5.1"
  #export PATH="$PATH:/Library/Developer/Ice-3.5.1/bin"

  # ruby/bundler
  export PATH="$PATH:/usr/local/Cellar/ruby193/1.9.3-p545/bin";

fi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/git/bin:$PATH"
export PATH="./bin:$HOME/.bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/git/man:$MANPATH"

#export GOPATH=$HOME/go
#export GOROOT=`go env GOROOT`
#export PATH=$PATH:$GOROOT/bin
