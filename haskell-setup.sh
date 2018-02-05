#! /bin/sh

# Based heavily on http://www.stephendiehl.com/posts/vim_2016.html

# Install Stack
curl -sSL https://get.haskellstack.org/ | sh
stack setup

# Install vim plugins
cd ~/.vim/bundle/
git clone https://github.com/eagletmt/ghcmod-vim.git
git clone https://github.com/eagletmt/neco-ghc
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/godlygeek/tabular.git
git clone https://github.com/ervandew/supertab.git
git clone https://github.com/Shougo/neocomplete.vim.git

# Vimproc is special
git clone https://github.com/Shougo/vimproc.vim.git
cd vimproc.vim
make

cd ~/

# External dependencies
sudo apt-get install libtinfo-dev

# Install ghc-mod and hlint
stack install hlint ghc-mod
