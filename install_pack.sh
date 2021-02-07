
sudo apt-get install -y libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 liblua5.1-0-dev libperl-dev git dos2unix sed cscope id-utils exuberant-ctags fontconfig language-pack-zh-hans libncurses5-dev exuberant-ctags silversearcher-ag gawk libncurses5 libtinfo5
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
