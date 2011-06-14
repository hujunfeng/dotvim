# How to install this Vim environment on your machine

1. Clone this repository:

		git clone git://github.com/hujunfeng/dotvim.git ~/.vim

1. Clone all submodules:

		cd ~/.vim
		git submodule update --init

1. Make symbolic links to vimrc files in home directory:

		ln -s ~/.vim/vimrc ~/.vimrc
		ln -s ~/.vim/gvimrc ~/.gvimrc

1. Create auxiliary folders: 

		mkdir ~/.vim/tmp/{backup,swap,undo}
