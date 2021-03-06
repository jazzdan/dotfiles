#!/bin/bash

alias ll='ls -al'
alias l='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim'
alias gdiff='gist -t diff'
alias git-root='cd $(git rev-parse --show-cdup)'
alias vidiff='git-root && vi $(git status --porcelain | awk '"'"'{print $2}'"'"')'
alias g='git'
alias ta='tmux -u attach'
alias td='tmux -u attach -d'
alias vim='nvim'
alias j='jira'
alias jme='jira ls -p DISCO -a dmiller'
alias jsprint='jira ls -q "assignee was dmiller AND updatedDate > -1w" -t table'

function jgrab { jira edit "$1" --noedit -o assignee=dmiller -o comment="I'll take care of this"; }
function jcomment { jira comment "$1" -m "$2"; }
function jprogress { jira trans progress "$1" --noedit; }
function jclose { jira close "$1" -o resolution="resolved" --noedit; }
function jshow { jira view "$1"; }

omni () {
    git rpull && knife spork omni "$@" && git commit --amend && git rpull && git push && knife spork promote "$@" --remote
}

PS1="[\w]> "

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR='code'

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/development/go

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export GEM_HOME="/usr/lib64/ruby/gems/1.9.1/gems"

export XDEBUG_CONFIG="idekey=key_doesnt_matter"

export GO15VENDOREXPERIMENT=1

. /home/dmiller/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true # ocaml stuff

set -o vi

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

export NVM_DIR="/home/dmiller/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='
  (git ls-tree -r --name-only HEAD ||
         find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
        sed s/^..//) 2> /dev/null'

PATH="$PATH:/home/dmiller/flow/"
PATH="/home/dmiller/.local/bin:$PATH"

# added by travis gem
[ -f /home/dmiller/.travis/travis.sh ] && source /home/dmiller/.travis/travis.sh
