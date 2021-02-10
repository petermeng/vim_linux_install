#!/bin/bash -
set -o nounset
selfpath=$(cd "$(dirname) "$0")"; pwd)

sudo apt-get install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-0-dev libperl-dev git dos2unix sed cscope id-utils exuberant-ctags fontconfig language-pack-zh-hans libncurses5-dev exuberant-ctags silversearcher-ag gawk libncurses5 libtinfo5 
sudo apt-get install -y python3-dev python3-pip python3-setuptools curl fctix

#install the fuck application
sudo pip3 install thefuck

# install albert
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt-get update
sudo apt-get install albert

# install ranger
if [ !-d "~/Documents/ranger" ]; then
    cd ~/Documents
    git clone https://github.com/ranger/ranger.git
fi
cd ~/Documents/ranger
git pull
sudo apt-get install w3m w3m-img
sudo pip3 install ueberzug

pythonName=`find /usr/lib/python3.* -maxdepth 0 -type d`
if [[ ${pythonName} ]]; then
    for line in ${pythonName}
    do
        pythonConfigFolder=`ls ${line} | grep "config-"`
        echo ${pythonConfigFolder}
        if [[ ${pythonConfigFolder} ]]; then
            python3Folder="${line}/${pythonConfigFolder}"
            if [ -d "${python3Folder}" ];then
                echo ${python3Folder}
                break
            fi
        fi
    done
fi

# install fzf application
if [ !-d "~/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install

# install i3
sudo apt-get install i3 -y

# install i3-gaps
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt-get update
sudo apt-get install -y i3-gaps
sudo apt-get install -y compton

# install xfce4 xfce4-power-manager
sudo apt-get install -y xfce4 xfce4-power-manager

# install tmux
if [ !-d "~/Documents/tmux" ]; then
    cd ~/Documents/
    git clone https://github.com/tmux/tmux.git
fi
cd ~/Documents/tmux
git pull
make distclean
./autogen.sh
./configure && make
sudo make install

# install alacritty
sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cd ~/Documents
if [ !-d "alacritty" ]; then
    git clone https://github.com/alacritty/alacritty.git
fi
cd alacritty
sudo apt-get install -y fonts-firacode
cargo install alacritty

# install polabar
sudo apt-get install build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
sudo apt-get install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev
if [ !-d "~/Documents/polybar" ]; then
    cd ~/Documents
    git clone --recursive https://github.com/polybar/polybar
fi
cd ~/Documents/polybar
rm -rf build
mkdir build
cd build
cmake ../
make && sudo make install

# copy the configuration into .config folder
cd ${selfpath}
cp -rf .config ~/
ln -s -f ${selfpath}/tmuxconfig/.tmux.conf ~/.tmux.conf
cp ${selfpath}/tmuxconfig/.tmux.conf.local ~/
