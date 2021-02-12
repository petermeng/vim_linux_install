export PLUG_DIR=$HOME/.zim
if [[ ! -d $PLUG_DIR ]]; then
	#curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
    wget https://raw.githubusercontent.com/zimfw/install/master/install.zsh 
    chmod 777 install.zsh
    zsh install.zsh
	rm ~/.zimrc
	ln -s ~/.config/zsh/zimrc ~/.zimrc
fi
