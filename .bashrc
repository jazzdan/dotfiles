alias ll='ls -al'
alias l='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias tl='sudo tail -F /var/log/httpd/php.log /var/log/httpd/info.log /var/log/httpd/error_log /var/log/gearman/php.log'
alias vi='vim'
alias gdiff='gist -t diff'
alias git-root='cd $(git rev-parse --show-cdup)'
alias vidiff='git-root && vi $(git status --porcelain | awk '"'"'{print $2}'"'"')'
alias g='git'
alias ta='tmux -u attach'
alias td='tmux -u attach -d'

ggb() {
    git grep -n $1 | while IFS=: read i j k; do git blame -L $j,$j $i | cat; done
}

omni () {
    git rpull && knife spork omni "$@" && git commit --amend && git rpull && git push && knife spork promote "$@" --remote
}

PS1="[\w]> "

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR='vim'

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/development/go

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export GEM_HOME="/usr/lib64/ruby/gems/1.9.1/gems"

export XDEBUG_CONFIG="idekey=key_doesnt_matter"

set -o vi

# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

export NVM_DIR="/home/dmiller/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
