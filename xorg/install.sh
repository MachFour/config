#! /bin/bash

cd ~
for file in Xdefaults Xresources xsession; do
	ln -sfv ".config/xorg/$file" ".${file}"
done
