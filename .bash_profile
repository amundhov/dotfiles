. $HOME/.bashrc

export PATH=/usr/local/bin:${PATH}:/usr/local/sbin:/usr/local/games:~/.local/bin

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init - bash --no-rehash)"
fi
