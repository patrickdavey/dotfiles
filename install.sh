#!/bin/bash

# script to stow all the subdirectories
set -e

function main {
  for directory in `find . -type d -maxdepth 1 -mindepth 1`; do
    if [ $directory = "./.git" ]; then
      continue
    fi

    if [ $directory = "./junk_drawer_dont_install" ]; then
      continue
    fi

    package=`echo $directory | tr "./" " "`
    echo "stowing: $package"

    if [ $directory = "./powerline_config" ]; then
      `stow -t ~/.config/ powerline_config/`
      continue
    fi

    if [ $directory = "./nvim" ]; then
      `stow -t ~/.config/ nvim/`
      continue
    fi

    `stow $package`

  done

  if ! hash fzf 2>/dev/null; then
     echo "don't forget to install fzf from https://github.com/junegunn/fzf"
  fi

  if ! hash task 2>/dev/null; then
     echo "don't forget to install taskwarrior from https://taskwarrior.org/download/"
  fi
}

main
