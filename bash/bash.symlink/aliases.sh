# cd
alias ..='cd ..'

# this alias supports the completions in ProjectCompletions
# see completions.sh
alias c='cd ~/code; cd '

# ls
#alias ls='ls --color=auto'
alias l="ls -lAh"
alias ll="ls -l"
alias la='ls -A'

# git
alias gs='git status'
alias gst='git status'
alias gc='git commit'
alias gca='git commit -a'
alias ga='git add'
alias gaa='git add .'
alias gco='git checkout'
alias gb='git branch'
alias gm='git merge'
alias gl='git pull'
alias gp='git push'
alias gd='git diff'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias greset="git reset --hard HEAD"

# rails
alias sc='script/console'
alias ss='script/server'
alias sg='script/generate'
alias a='autotest'
alias tlog='tail -f log/development.log'
alias alog='tail -f /var/log/apache2/*'
alias scaffold='script/generate nifty_scaffold'
alias migrate='rake db:migrate db:test:clone'
alias rst='touch tmp/restart.txt'
alias dep='gp;cap staging deploy:migrations'
alias depp='gp;cap production deploy:migrations'

# switch between ruby versions
alias r186='export PATH=~/.multiruby/install/1.8.6-p383/bin:$ORIGPATH'
alias r187='export PATH=~/.multiruby/install/1.8.7-p174/bin:$ORIGPATH'
alias r191='export PATH=~/.multiruby/install/1.9.1-p243/bin:$ORIGPATH'
alias roff='export PATH=$ORIGPATH'

# commands starting with % for pasting from web
alias %=' '

# remotes
alias ox='ssh nihildeb@oxfammodels.com'
alias hm='ssh nihildeb@chef.happymoose.com'
alias ec2='ssh -i ~/.ssh/nihildeb.pem root@50.16.230.4'

alias irc='ssh -t nihildeb@oxfammodels.com screen -xr'
alias stage='ssh deploy@staging.willitping.com'
alias prod='ssh deploy@willitping.com'

# arch
alias p='pacman -Ss'
alias pi='sudo pacman -S'
alias y='yaourt -Ss'
alias yi='yaourt -S'

# misc
alias src='source ~/.bashrc'
alias dot='$EDITOR ~/code/dotfiles'
alias screen='screen -RU'

# node
alias r='redis-cli'

# misc
#alias xterm="xterm -fa 'bitstream\ vera\ sans\ mono' -fs 9 -bg black -fg white -geo 999x999"

# MacVim
# $EDITOR in .bash/config.sh
# alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim -f'

# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias ios="open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
