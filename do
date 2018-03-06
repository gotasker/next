#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}");

declare gpath=$("pwd");
declare project="";
if [[ $gpath =~ (.*\/)(.*) ]]; then
    project=${BASH_REMATCH[2]}
fi
export GOPATH=$gpath;
declare bin=$gpath/bin;
declare binka=$bin/$project;
declare par=$1;

if [[ $par == b ]]; then
    declare err=$(go install $project 2>&1 >/dev/null); # build and put an error into var err

    if [[ ! -z $err ]]; then
        echo "$err";
        exit 0;
    fi

    if [[ -e $binka ]]; then
        echo "ok";
        exit 0;
    fi

    echo "$binka not found";
    exit -1;
fi

if [[ $par ]]; then
    echo "The parameter \"$par\" is wrong";
    exit 0;
fi

if [[ -e $binka ]]; then
    clear screen;

    if [ ! -e "$bin/templates" ]; then
        ln -s "$gpath/src/next/templates" "$bin/templates"
    fi

    cd $bin;
    $binka;
else
    echo -e "$binka not found";
fi