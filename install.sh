#!/bin/bash

# script to stow all the subdirectories
set -e

function main {

  mkdir -p  ~/.config/git
  mkdir -p  ~/.config/alacritty

  for directory in `find . -type d -maxdepth 1 -mindepth 1`; do
    if [ $directory = "./.git" ]; then
      continue
    fi

    if [ $directory = "./junk_drawer_dont_install" ]; then
      continue
    fi

    if [ $directory = "./config" ]; then
      `stow -t ~/.config/git -d ./config/ -S git`
      `stow -t ~/.config/alacritty -d ./config/ -S alacritty`
      continue
    fi

    package=`echo $directory | tr "./" " "`
    echo "stowing: $package"

    if [ $directory = "./powerline_config" ]; then
      `stow -t ~/.config/ powerline_config/`
      continue
    fi

    `stow $package`

  done

  if ! hash fzf 2>/dev/null; then
     echo "don't forget to install fzf from https://github.com/junegunn/fzf"
  fi
}

if ! hash exa 2>/dev/null; then
   echo "please install exa before continuing"
   exit -1
fi

if ! hash rg 2>/dev/null; then
   echo "please install ripgrep before continuing"
   exit -1
fi
main
