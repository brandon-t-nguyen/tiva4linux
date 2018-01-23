#!/bin/bash
install_dir="$HOME/embedded"
tivaware_dir="$install_dir/tivaware"
lm4tools_dir="$install_dir/lm4tools"
script_dir=$(pwd)

if [ $# -ge 2 ]; then
    install_dir=$1
fi

if ! which arm-none-eabi-gcc > /dev/null;
then
    echo "ERROR: ARM toolchain is not setup properly. Are you sure you downloaded the ARM toolchain?"
    exit 1
fi

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
mkdir -p projects

cd $script_dir

cp copy_scripts/mkproj.sh $install_dir/projects/mkproj.sh

# sed the tiva-template Makefile and put the correct TIVAWARE_PATH variable
find_str='$(HOME)/embedded/tivaware'
find_str=$(echo "$find_str" | sed -e 's/\//\\\//g')

rep_str="$install_dir/tivaware"
rep_str=$(echo "$rep_str" | sed -e 's/\//\\\//g')

sed_exp="s/$find_str/$rep_str/g"
echo $sed_exp
sed -i $sed_exp $install_dir/tiva-template/Makefile
#

echo "You will want to add the lm4flash to your PATH. It's located at $lm4tools_dir/lm4flash"
echo "Your project directory will be located at $install_dir/projects"
echo "Use the mkproj.sh script located in $install_dir/projects to create a new project"
