#!/bin/sh

# HELP: Update Arch linux

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman -Syu;

