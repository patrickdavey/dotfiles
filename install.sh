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

    `stow $package`
  done
}

main
