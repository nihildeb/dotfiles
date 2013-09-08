#!/usr/bin/env bash

if [ ! -d "$HOME/code" ]; then
  mkdir -p "$HOME/code"
fi

cd "$HOME/code"

if [ ! -d "$HOME/code/dotfiles" ]; then
  git clone --recursive git@github.com:nihildeb/dotfiles.git
fi

cd "$HOME/code/dotfiles"
git pull
git submodule update --recursive

# update dotfiles
./script/bootstrap

# update bash
$HOME/.bash-it

# update vim bundles
$EDITOR +BundleInstall +qall


