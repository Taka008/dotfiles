#!/bin/bash

set -xu

mkdir -p ~/.emacs.d
mkdir -p ~/.config
mkdir -p ~/.config/git
mkdir -p ~/.config/peco

# install Homebrew/Linuxbrew if not installed
if !(type brew &> /dev/null); then
  case "${OSTYPE}" in
    linux* | cygwin*)
      HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"${HOME}/.linuxbrew"}
      ;;
    freebsd* | darwin*)
      if [[ $(uname -m) == "arm64" ]]; then
        HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"/opt/homebrew"}
      else
        # x86_64
        HOMEBREW_PREFIX=${HOMEBREW_PREFIX:-"/usr/local"}
      fi
      ;;
  esac
fi

# install zinit
if ! [[ -d ${HOME}/.zinit ]]; then
  mkdir ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

# install poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python