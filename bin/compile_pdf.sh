#!/bin/bash


# Compile a .tex file to pdf, if necessary
set -e 
set -o pipefail

function usage() {
    echo "Usage: FILENAME"
    exit 1
}

tex="$1"

if [[ ! -f "$tex" ]]
then
    usage
fi

if ! grep -q '.tex$' <(echo $tex) 
then
    echo "ERROR: filename must end in .tec"
    exit 1
fi

shortname="$(echo $tex | sed 's/.tex$//g')"
pdf="$shortname.pdf"


if [[ ! -f "$pdf" ]]
then
    echo "PDF does not exist, building!"
elif [[ "$(gstat -c %Y $tex)" -gt "$(gstat -c %Y $pdf)" ]]
then
    echo "PDF is older than tex, building!"
else
    echo "PDF is up-to-date!"
    exit 0
fi

texi2pdf $tex -o $pdf |sed 's/^/  /g'
