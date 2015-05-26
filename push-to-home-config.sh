#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
home_config="/home/phil/.config/geany/plugins/geanylua"

if [ -z ${1+x} ]; then
	echo "push-to-home-config requires at least one filename parameter"
else
    for file in "$@"; do
        if [ -f "${file}" ]; then
            cp "${file}" "${home_config}"
        else
            echo "no file '${file}' was found."
        fi
    done
fi
