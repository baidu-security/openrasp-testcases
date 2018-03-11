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

    for x in S2-016 fastjson vulns
    do
        log2 $x
        cd "$x" && mvn package
        mv target/$x.war ../../output/ && rm -rf target && cd ../
    done
}

log 'Preparing ..'
rm -rf output
mkdir -p output

log 'Build war(s) ...'
(build_java)

log 'See output/'
ls output

