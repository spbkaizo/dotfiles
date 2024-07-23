# Parts taken from https://github.com/mattmc3/zshrc1/blob/main/.zshrc1

#region History
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep            # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
setopt no_share_history        # don't share history between all sessions

#region Zsh Options
#
# http://zsh.sourceforge.net/Doc/Release/Options.html
# https://github.com/zshzoo/setopts
#
# changing directories
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir

# zle
# http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
setopt beep

# job control
# http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
setopt   notify


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
zstyle :compinstall filename '${HOME}/.zshrc'

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
if [[ "$OSTYPE" != "darwin"* ]]; then
    alias sudo=doas
fi

#export NNTPSERVER="csiph.com"
export NNTPSERVER="nntp.aioe.org"

# PF aliases, to make life easier...
alias pflog="doas tcpdump -nettti pflog0"
alias pftop="doas pftop"
alias pfinfo="doas pfctl -s info"
alias pfstat="doas pfctl -vvsr"

# make obsd more linux like... 
#alias killall="zap -s9 "

# make the time command prettier!
TIMEFMT=$'Time spent in user mode (CPU seconds): %U\nTime spent in kernel mode (CPU seconds): %S\nTotal time: %E\nCPU utilisation (percentage): %P\nTimes the process was swapped: %w\nTimes of major page faults: %F\nTimes of minor page faults: %R\n'
