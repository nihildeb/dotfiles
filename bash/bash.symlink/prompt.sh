#!/usr/bin/env bash

source "$HOME/.bash/lib/git-prompt.sh"

# http://blog.bitfluent.com/post/27983389/git-utilities-you-cant-live-without
# http://superuser.com/questions/31744/how-to-get-git-completion-bash-to-work-on-mac-os-x
# http://tammersaleh.com/posts/a-better-rvm-bash-prompt
# https://rvm.beginrescueend.com/workflow/prompt/

# 17:39:15 henrik@Nyx project_dir ree-1.8.7@project master*$

function __git_prompt {
  if [[ -d .git ]]; then
    GIT_PS1_SHOWDIRTYSTATE=1
    [ `git config user.pair` ] && GIT_PS1_PAIR="`git config user.pair`@"
    __git_ps1 " $GIT_PS1_PAIR%s" | sed 's/ \([+*]\{1,\}\)$/\1/';
  fi
}

bash_prompt() {

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\033[1;30m\]"
  local BR="\[\033[1;31m\]"
  local BG="\[\033[1;32m\]"
  local BY="\[\033[1;33m\]"
  local BB="\[\033[1;34m\]"
  local BM="\[\033[1;35m\]"
  local BC="\[\033[1;36m\]"
  local BW="\[\033[1;37m\]"

  # reset
  local RESET="\[\033[0;37m\]"
  local N="\[\e[39m\]" # no color?

  #don't use bins for username password
  PS1="$Y\t$N ○ [$B\u@\H$N] ○$C\$(__git_prompt)\n$W\w$N $ "
}

bash_prompt
unset bash_prompt

eval "$(fasd --init posix-alias bash-hook)"
alias v='f -e vim'
alias c='fasd_cd -d'


