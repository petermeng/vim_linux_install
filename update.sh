#!/bin/bash -
#===============================================================================
#
#          FILE: install.sh
#
#         USAGE: ./install.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/15/2018 09:25:59 AM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
cd ~/Documents/vim
git pull
sudo apt-get update
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
make distclean
pythonName=`find /usr/lib/python3.* -maxdepth 0 -type d`
if [[ ${pythonName} ]]; then
    pythonConfigFolder=`ls ${pythonName} | grep "config-"`
    if [[ ${pythonConfigFolder} ]]; then
        python3Folder="${pythonName}/${pythonConfigFolder}"
        if [ -d "${python3Folder}" ];then
            echo ${python3Folder}
        fi
    fi
fi
pythonName=`find /usr/lib/python2.* -maxdepth 0 -type d`
if [[ ${pythonName} ]]; then
    pythonConfigFolder=`ls ${pythonName} | grep "config-"`
    if [[ ${pythonConfigFolder} ]]; then
        python2Folder="${pythonName}/${pythonConfigFolder}"
        if [ -d "${python2Folder}" ];then
            echo ${python2Folder}
        fi
    fi
fi
sudo ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=${python2Folder} \
            --enable-python3interp=yes \
            --with-python3-config-dir=${python3Folder} \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --enable-gui=auto --with-x=yes --prefix=/usr

make -j4 VIMRUNTIMEDIR=/usr/share/vim/vim82


sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
sudo update-alternatives --set editor /usr/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
sudo update-alternatives --set vi /usr/bin/vim
