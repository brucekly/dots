# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export EDITOR=vim

HISTCONTROL=ignoreboth
shopt -s histappend

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias e="$EDITOR"
alias ec="emacsclient -n"
alias g="git"
alias l="ls -al --group-directories-first"
