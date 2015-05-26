#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
home_config="/home/phil/.config/geany/plugins/geanylua"

if [ -z ${1+x} ]; then
	echo "push-to-home-config requires a filename parameter"
else
	fileToPush="${1}"
	if [ -f "${fileToPush}" ]; then
		cp "${DIR}/${fileToPush}" "${home_config}/${fileToPush}"
	else
		echo "no file '${DIR}/${fileToPush}' was found."
	fi
fi
