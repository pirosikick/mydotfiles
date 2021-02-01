LIST = .vimrc .zshrc .zshenv .gitconfig .peco.zsh

link:
	SRC=`pwd`;\
	LIST="$(LIST)";\
	for x in $$LIST; do\
		ln -s $$SRC/$$x $$HOME/$$x;\
	done;\
	git clone git://github.com/Shougo/neobundle.vim.git $$HOME/.vim/bundle/neobundle.vim
unlink:
	PWD=`pwd`;\
	LIST="$(LIST)";\
	for x in $$LIST; do\
		SRC="$$PWD/$$x";\
		PATH="$$HOME/$$x";\
		if [ -L $$PATH ]; then\
			LINK_TO=`/usr/bin/readlink $$PATH`;\
			if [ "x$$LINK_TO" != "x$$SRC" ]; then\
				/bin/rm $$PATH;\
			fi;\
		fi;\
	done
update: unlink link
