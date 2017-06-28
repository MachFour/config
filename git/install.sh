#! /bin/bash

cd ~
for file in gitconfig; do
	ln -sfv ".config/git/$file" ".${file}"
done
