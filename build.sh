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
    for x in S2-016 fastjson vulns
    do
        log2 $x

        (
            cd "java/$x" 
            mvn clean package 
            mv target/$x.war ../../output/
            mvn clean
        )
    done
}

function build_php()
{
    (cd php; tar -czf ../output/php-vulns.tar.gz vulns)
}

log 'Preparing ..'
rm -rf output
mkdir -p output

log 'Build ...'
build_java
build_php

log 'See output/'
ls output

