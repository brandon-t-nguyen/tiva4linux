#!/bin/bash

# mkproj.sh <project name>
if [ $# -lt 1 ]; then
    echo "ERROR: provide project name"
    echo "mkproj.sh <project name>"
    exit 1
fi

proj_name=$1

target=$proj_name
cp -r ../tiva-template $target
cd $target

# remove the git directory
rm -rf .git
