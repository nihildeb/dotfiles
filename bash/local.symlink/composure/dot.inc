#!/bin/bash

export DOTFILES_HOME="$HOME/.dotfiles"
export DOTFILES_MEMDIR=""

dot () 
{ 
    about 'echo dotfiles path';
    group 'dotfiles';

    echo $HOME/.dotfiles/
}

cdot() {
    about 'change to dotfiles dir';
    group 'dotfiles';

    DOTFILES_MEMDIR=$(pwd)
    cd $(dot)
}

uncdot() {
    about 'change back to previous dir';
    group 'dotfiles';

    cd $(DOTFILES_MEMDIR)
}


