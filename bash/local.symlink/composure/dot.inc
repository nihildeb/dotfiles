#!/bin/bash

export DOTFILES_HOME="$HOME/.dotfiles"
previous_dir=""

dot () 
{ 
    about 'echo dotfiles path';
    group 'dotfiles';

    echo $HOME/.dotfiles/
}

cdot() {
    about 'change to dotfiles dir';
    group 'dotfiles';

    previous_dir=$(pwd)
    cd dot
}

uncdot() {
    about 'change back to previous dir';
    group 'dotfiles';

    cd previous_dir
}


