#!/bin/bash

set -e
cd "$(dirname "$0")"

function log() 
{
    echo '[-]' $@
}

function log2() 
{
    echo '    -' $@
}

function build_java() 
{
    cd java

    for x in *
    do
    	log2 "$x"

        name="$x.war"
        jar -cf ../output/"$name" "$x"
    done
}

log 'Preparing ..'
rm -rf output
mkdir -p output

log 'Build war(s) ...'
(build_java)

log 'See output/'
ls output

