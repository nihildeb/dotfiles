#!/usr/bin/env bash

if [ ! -d "$HOME/code" ]; then
  mkdir -p "$HOME/code"
fi

cd "$HOME/code"

if [ ! -d "$HOME/code/dotfiles" ]; then
  git clone git@github.com:nihildeb/dotfiles.git
fi

cd "$HOME/code/dotfiles"
git pull
git submodule update --init --recursive
$EDITOR +BundleInstall +qall
