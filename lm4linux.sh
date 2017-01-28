#!/bin/bash
install_dir="$HOME/embedded-test"
tivaware_dir="$install_dir/tivaware"
lm4tools_dir="$install_dir/lm4tools"
script_dir=$(pwd)

if [ ! -e ./tivaware.exe ]
then
    echo "ERROR: Please download the latest Tivaware and put it in this directory as tivaware.exe"
    exit 1
fi

mkdir -p $install_dir
unzip tivaware.exe -d $tivaware_dir

cd $tivaware_dir
make

cd ..
git clone git://github.com/utzig/lm4tools.git
cd lm4tools/lm4flash
make

cd $install_dir
git clone git://github.com/aeturnus/tiva-template.git

cd $script_dir
