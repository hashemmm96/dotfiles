#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias skype='apulse32 skype'

PS1='[\u@\h \W]\$ '

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# fix CURL certificates path
export CURL_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

# Set colors based on ~/.colors file
source ~/.colors
