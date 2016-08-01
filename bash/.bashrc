export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
export CLICOLOR=1
export LSCOLORS='exFxCxDxBxegedabagaced'
export GREP_OPTIONS='--color=auto'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin # Add local bin directory

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

export EDITOR=vim
set -o vi
bind -m vi-command '.:insert-last-argument'
HISTSIZE=10000

# Ctrl-p: search in previous history
 bind 'Control-p: history-search-backward'
 bind -m vi-insert 'Control-p: history-search-backward'
 bind -m vi-command 'Control-p: history-search-backward'

# Ctrl-n: search in next history
 bind 'Control-n: history-search-forward'
 bind -m vi-insert 'Control-n: history-search-forward'
 bind -m vi-command 'Control-n: history-search-forward'

 bind "Control-t: forward-search-history"

#add powerline bash
function _update_ps1()
{
   export PS1="$(~/powerline-bash.py $?)"
}

export PROMPT_COMMAND="_update_ps1"

# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups  
# append history entries..
shopt -s histappend

# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

function rtags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle exec list --paths)
}


source ~/.git-completion.bash
source /usr/local/etc/bash_completion.d/password-store
alias ctags="`brew --prefix`/bin/ctags"

PATH=$PATH:.

