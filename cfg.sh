#!/bin/bash

if [ ! -z "$1" ]; then
	if [ "$1" = "develop" ]; then
		nix develop --extra-experimental-features nix-command --extra-experimental-features flakes
	elif [ "$1" = "build" ]; then
		nix build --extra-experimental-features nix-command --extra-experimental-features flakes
	else
		echo "Usage: ./cfg < develop | build >"
	fi
else
	echo "Usage: ./cfg < develop | build >"
fi
