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
	if [ "$x"x = "fastjson"x ] || [ "$x"x = "sqlcase"x ]; then 
	    cd $x && mvn package
	    mv target/$x.war ../../output/ && rm -rf target && cd ../
	else
            name="$x.war"
            jar -cf ../output/"$name" "$x"/*
	fi
    done
}

log 'Preparing ..'
rm -rf output
mkdir -p output

log 'Build war(s) ...'
(build_java)

log 'See output/'
ls output

