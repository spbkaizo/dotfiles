HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep notify
bindkey -v
zstyle :compinstall filename '${HOME}/.zshrc'

#alias gopher="gopherfs gopher://gopher.floodgap.com /srv/gopher && cd /srv/gopher && ls -l "

#PATH=$PATH:/opt/jdk1.7.0_45/bin
export PATH=${HOME}/go/bin:${HOME}/src/gocode/bin/:$PATH:~/bin/:/usr/local/bin:/usr/local/sbin:/usr/local/jdk-1.7.0/bin
export GOPATH=$HOME/src/gocode

export EDITOR=vim

autoload -U promptinit
promptinit

# prompt adam1
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

prompt clint

# aliases
#alias ls="ls --color "
alias ll="ls -la"
alias ls="ls-go"
alias -s pdf=evince
alias -s mp3=mpg123
alias -s go="go run"

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s

autoload -Uz compinit
compinit

alias vi=vim

#export NNTPSERVER="csiph.com"
export NNTPSERVER="nntp.aioe.org"

# PF aliases, to make life easier...
alias pflog="sudo tcpdump -nettti pflog0"
alias pftop="sudo pftop"
alias pfinfo="sudo pfctl -s info"
alias pfstat="sudo pfctl -vvsr"

# make obsd more linux like... 
#alias killall="zap -s9 "
