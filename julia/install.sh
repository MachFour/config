#! /bin/bash

cd ~
thisdir=julia
files="juliarc.jl"
for file in $files; do
	ln -sfv ".config/$thisdir/$file" ".${file}"
done
