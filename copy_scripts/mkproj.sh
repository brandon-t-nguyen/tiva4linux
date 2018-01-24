#!/bin/bash

# mkproj.sh <project name>
if [ $# -lt 1 ]; then
    echo "ERROR: provide project name"
    echo "mkproj.sh <project name>"
    exit 1
fi

proj_name=$1

if [ -e ./$proj_name ]; then
    echo "ERROR: project \"$proj_name\" already exists"
    exit 1
fi

target=$proj_name
cp -r ../tiva-template $target
cd $target

# remove the git directory
rm -rf .git
