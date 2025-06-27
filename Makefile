install:
	install -m 0600 dot.vimrc ${HOME}/.vimrc
	install -m 0600 dot.zshrc ${HOME}/.zshrc
	install -m 0600 dot.zlogin ${HOME}/.zlogin
	install -m 0600 dot.Xdefaults ${HOME}/.Xdefaults
	install -m 0600 dot.tmux.conf ${HOME}/.tmux.conf
	install -m 0700 -d ${HOME}/.ssh/
	install -m 0600 dot.ssh_config ${HOME}/.ssh/config
