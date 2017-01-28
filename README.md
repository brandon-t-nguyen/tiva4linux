# Tiva 4 Linux 
This repository is composed of a script to help automate installation of a TI Tiva toolchain.

Due to licensing issues, the Tivaware itself is not packaged in this repo. You will have to download it yourself.

This is only possible due to the guide here: http://chrisrm.com/howto-develop-on-the-ti-tiva-launchpad-using-linux/
and the repos https://github.com/uctools/tiva-template and  https://github.com/uctools/tiva-template

### Dependencies
There are multiple dependencies needed. Consult your package manager for installation if you aren't using apt:
* unzip
* flex
* bison
* libgmp3-dev
* libmpfr-dev
* libncurses5-dev
* libmpc-dev
* autoconf
* texinfo
* libftdi-dev
* python-yaml
* zlib1g-dev

To get all dependencies on Ubuntu, using apt:

    apt-get install unzip flex bison libgmp3-dev libmpfr-dev libncurses5-dev \
    libmpc-dev autoconf texinfo build-essential libftdi-dev python-yaml \
    zlib1g-dev

In addition, the ARM toolchain for Linux will be needed.
If you're on Ubuntu, follow the instructions here: https://launchpad.net/~team-gcc-arm-embedded/+archive/ubuntu/ppa
If you are on Arch, there is an official package for it.
Otherwise, download it directly and add the binaries to your PATH:  https://launchpad.net/gcc-arm-embedded

### Tivaware
Once the dependencies are resolved, you will need the latest version of the TM4C123 Tivaware from the TI website: http://software-dl.ti.com/tiva-c/SW-TM4C/latest/index_FDS.html

Download the "TivaWare for TM4C Series" version. *Put it in this repo's directory under the name "tivaware.exe"*.

### Running
Run the script lm4linux.sh
