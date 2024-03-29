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
selfpath=$(cd "$(dirname "$0")"; pwd) 
cd ~/Documents/
if [ -d "~/Documents/vim" ];then
    echo "has vim"
else
    git clone https://github.com/vim/vim.git
fi
cd ~/Documents/vim
git pull
sudo apt-get update
sudo apt-get install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-0-dev libperl-dev git dos2unix sed cscope id-utils exuberant-ctags fontconfig language-pack-zh-hans libncurses5-dev exuberant-ctags silversearcher-ag gawk libncurses5 libtinfo5 ripgrep bat
make distclean
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
pythonName=`find /usr/lib/python2.* -maxdepth 0 -type d`
if [[ ${pythonName} ]]; then
    for line in ${pythonName}
    do
      pythonConfigFolder=`ls ${pythonName} | grep "config-"`
      if [[ ${pythonConfigFolder} ]]; then
          python2Folder="${pythonName}/${pythonConfigFolder}"
          if [ -d "${python2Folder}" ];then
              echo ${python2Folder}
              break
          fi
      fi
    done
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

cd ~/Documents
if [ -d "~/Documents/main" ];then
    echo "has main"
else
    git clone https://github.com/petermeng/exvim_linux.git ~/Documents/main
fi
vimplugFolder=~/Documents/main/vimfiles/bundle/vim-plug
if [ -d "${vimplugFolder}" ];then
    echo "has ${vimplugFolder}"
else
    git clone https://github.com/junegunn/vim-plug.git ${vimplugFolder}
fi
if [ ! -d "~/.undo_history" ];then
    mkdir ~/.undo_history
fi
if [ ! -d "~/.session_history/" ];then
    mkdir ~/.session_history
fi
mkdir ${vimplugFolder}/autoload/
cp ${vimplugFolder}/plug.vim ${vimplugFolder}/autoload/
chmod 777 ~/Documents/main/unix/gvim.sh
chmod 777 ~/Documents/main/unix/vim.sh
grep -l "alias mygvim='~/Documents/main/unix/gvim.sh'" ~/.bashrc
if [ $? -eq 0 ];then
    echo "has mygvim"
else
    echo "alias mygvim='~/Documents/main/unix/gvim.sh'" >> ~/.bashrc
fi
grep -l "alias myvim='~/Documents/main/unix/vim.sh'" ~/.bashrc
if [ $? -eq 0 ];then
    echo "has myvim"
else
    echo "alias myvim='~/Documents/main/unix/vim.sh'" >> ~/.bashrc
fi
grep -l "export GTK_NATIVE_WINDOWS=1" ~/.bashrc
if [ $? -eq 0 ];then
    echo "has GTK config"
else
    echo "export GTK_NATIVE_WINDOWS=1" >> ~/.bashrc
fi
source ~/.bashrc
cd ${selfpath}
mkdir -p ~/.local/share/fonts
rm -rf ~/.local/share/fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/.local/share/fonts
fc-cache -vf ~/.local/share/fonts
~/Documents/main/unix/vim.sh +PlugInstall +qa
find ~/Documents/main/vimfiles/bundle -name "*.vim" | xargs dos2unix
vimPlugsFolder=~/Documents/main/vimfiles/bundle
if [ -f "${vimPlugsFolder}/git-support/plugin/git-support.vim" ];then
    sed -i 's/command  -nargs/command! -nargs/g' ${vimPlugsFolder}/git-support/plugin/git-support.vim
fi
if [ -f "${vimPlugsFolder}/bufexplorer/plugin/bufexplorer.vim" ];then
    sed -i 's/<Leader>bs :BufEx/<Leader>bss :BufEx/g' ${vimPlugsFolder}/bufexplorer/plugin/bufexplorer.vim
fi
if [ -f "${vimPlugsFolder}/vim-mark/plugin/mark.vim" ];then
    sed -i 's/<Leader>\/ <Plug>/<Leader>\/\/ <Plug>/g' ${vimPlugsFolder}/vim-mark/plugin/mark.vim
fi
if [ -f "${vimPlugsFolder}/vim-plugins/autoload/mmtemplates/core.vim" ];then
    sed -i "s/let jump_key = '<C-d>'/let jump_key = '<C-S-A-l>'/g" ${vimPlugsFolder}/vim-plugins/autoload/mmtemplates/core.vim
fi
