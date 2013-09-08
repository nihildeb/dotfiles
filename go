#!/usr/bin/env bash

mkdir -p "$HOME/code"
cd "$HOME/code"
git clone git@github.com:nihildeb/dotfiles.git
cd "$HOME/code/dotfiles"
git submodule update --init --recursive
