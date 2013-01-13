# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi


# User specific aliases and functions
#don't add commands that start with a space to the bash history
export HISTCONTROL=ignoreboth

#set vim as default editor
export EDITOR=vim


