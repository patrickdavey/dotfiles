
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/go/bin":$PATH
export PATH="/home/patrick/.local/bin":$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/dotfiles_bin:$PATH"
export PATH="$HOME/flutter_development/flutter/bin:$PATH"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"

export NVM_DIR="/Users/patrickdavey/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export CLICOLOR=1
# export LS_COLORS='exFxCxDxBxegedabagaced'
# export GREP_OPTIONS='--color=auto'
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

source "/etc/profile.d/rvm.sh"
PATH=$PATH:$HOME/bin # Add local bin directory

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

export EDITOR=vim
set -o vi
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

export PROMPT_COMMAND="_update_ps1"
# export LC_POWERLINE=1

### History related info

HISTSIZE=100000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

bind -m vi-command '.:insert-last-argument'

# Ctrl-p: search in previous history
 bind 'Control-p: history-search-backward'
 bind -m vi-insert 'Control-p: history-search-backward'
 bind -m vi-command 'Control-p: history-search-backward'

# Ctrl-n: search in next history
 bind 'Control-n: history-search-forward'
 bind -m vi-insert 'Control-n: history-search-forward'
 bind -m vi-command 'Control-n: history-search-forward'

 bind "Control-t: forward-search-history"

### ENDHISTORY

function rtags() {
    ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle show --paths)
}

function gmr() {
  NUMBER_TO_FETCH=${1:-20}
  git for-each-ref --sort=-committerdate refs/heads/  \
    --format="%(HEAD) %(color:cyan)%(refname:short)%(color:reset) | %(committerdate:relative)%(color:reset) | %(subject)" | \
    while IFS='|' read branchname date subject
    do
      printf "%s | %s | %.80s\n" "$branchname" "$date" "$subject"
    done | column -ts "|" | head -n $NUMBER_TO_FETCH
}

source ~/.git-completion.bash
# source /usr/local/etc/bash_completion.d/pass
# alias ctags="`brew --prefix`/bin/ctags"

PATH=$PATH:/Users/patrickdavey/Library/Android/sdk/platform-tools
PATH=$PATH:/Users/patrickdavey/Library/Android/sdk/tools
PATH=$PATH:/Users/patrickdavey/gradle-5.4.1/bin
#PATH=$PATH:/usr/local/heroku/bin:.
# only cd complete directories
complete -d cd

function fig {
  figlet -f banner $1 | sed -e"s/#/:$2:/g" | sed -e"s/ /:$3:/g" | pbcopy
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function ts {
  args=$@
  tmux send-keys -t right "$args" C-m
}
# source ~/.bash_completion/alacritty
