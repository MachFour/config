#! /bin/bash

cd ~
for zfile in zprofile zshrc zkbd; do
	ln -sfv ".config/zsh/$zfile" ".${zfile}"
done
