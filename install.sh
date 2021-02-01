#!/bin/bash

# Install rbenv + ruby-build
echo "rbenv + ruby-build: installing..."

if [ hash rbenv 2>/dev/null ]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

    echo "rbenv + ruby-build: finised.";
else
    echo "rbenv + ruby-build: already installed. skip.";
fi

# Install nodebrew
echo "nodebrew: installing..."

if [ hash nodebrew 2>/dev/null ]; then
    curl -L git.io/nodebrew | perl - setup
    echo "nodebrew: finished."
else
    echo "nodebrew: already installed."

    echo "nodebrew: updating..."
    nodebrew selfupdate
    echo "nodebrew: finished updating!"
fi

PWD=`pwd`
DOTS=".vimrc .gvimrc .zshrc .zsh .zfunc .gemrc .tmux.conf .vim/templates .vim/after .vim/ftdetect .vim/rc"

mkdir -p ~/.vim

echo "Link dotfiles: $DOTS"

for dotfile in $DOTS
do
    ln -snf $PWD/$dotfile ~/$dotfile
done

if [ ! -f $PWD/.gitconfig ]; then
    ln -snf $PWD/.gitconfig ~/.gitconfig
fi

unamestr=`uname`
if [[ $unamestr == 'Darwin' ]]; then
    if [ hash brew 2>/dev/null ]; then
        # Install homebrew
        echo "homebrew: installing..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
fi

if [ ! -e ~/.zsh/completion/_docker ]; then
  echo "Downloading docker completion..."
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > ~/.zsh/completion/_docker
fi

if [ ! -e ~/.zsh/completion/_docker-compose ]; then
  echo "Downloading docker compose completion..."
  curl -L  $ curl -L https://raw.githubusercontent.com/docker/compose/1.23.2/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
fi

