#!/bin/bash
install_dir="$HOME/embedded"
if [ $# -ge 1 ]; then
    install_dir=$1
fi
install_dir=$(readlink -m $install_dir)

tivaware_dir="$install_dir/tivaware"
lm4tools_dir="$install_dir/lm4tools"
profile_file="$HOME/.profile"
script_dir=$(pwd)

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

# get the default shell
def_shell=$(getent passwd $(whoami) | cut -d: -f7 | rev | cut -d '/' -f1 | rev)
if [ ! -z $def_shell ]; then
    profile_file="${HOME}/.${def_shell}rc"
fi

mkdir -p $install_dir
unzip tivaware.exe -d $tivaware_dir

cd $tivaware_dir
make

cd ..
git clone https://github.com/utzig/lm4tools.git
cd lm4tools/lm4flash
make

cd $install_dir
git clone https://github.com/aeturnus/tiva-template.git
mkdir -p projects

cd $script_dir

cp copy_scripts/mkproj.sh $install_dir/projects/mkproj.sh

echo ""

lm4flash_dir="$lm4tools_dir/lm4flash"
if $(cat $profile_file | grep lm4flash >> /dev/null); then
    echo "Set the lm4flash to your PATH in your $profile_file file. It is located at $lm4tools_dir/lm4flash"
    echo "Set the TIVAWARE_PATH variable to your $profile_file file. It is at $tivaware_dir."
    
    rep_str=$(echo "$lm4tools_dir/lm4flash" | sed -e 's/\//\\\//g')
    sed -i "s/:.*lm4flash/:$rep_str/g" $profile_file

    rep_str=$(echo "$tivaware_dir" | sed -e 's/\//\\\//g')
    sed -i "s/TIVAWARE_PATH=.*/TIVAWARE_PATH=$rep_str/g" $profile_file
else
    echo "Added lm4flash to your PATH in your $profile_file file. It is located at $lm4tools_dir/lm4flash"
    echo "Added the TIVAWARE_PATH variable to your $profile_file file. It is at $tivaware_dir."
    echo 'export PATH="$PATH:'"$lm4flash_dir\"" >> $profile_file
    echo "export TIVAWARE_PATH=\"$tivaware_dir\"" >> $profile_file
fi
echo "Add this path to any other shell configuration files if you want"
echo "You will want to to source it on other open shell sessions to access these variables."

echo ""
echo "Your project directory will be located at $install_dir/projects"

echo ""
echo "Use the mkproj.sh script located in $install_dir/projects to create a new project"

