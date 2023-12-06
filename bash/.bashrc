
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles_bin:$PATH"

if [ -d "$HOME/go/bin" ]; then
    PATH="$HOME/go/bin/:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export CLICOLOR=1
export LSCOLORS='exFxCxDxBxegedabagaced'
export GREP_OPTIONS='--color=auto'
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

eval "$(rbenv init -)"

PATH=$PATH:$HOME/bin # Add local bin directory
PATH=$PATH:$HOME/.mix/escripts # Add escripts for elixir livebook

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ -f ~/.secret_bash_aliases ]; then
  . ~/.secret_bash_aliases
fi


export EDITOR=nvim
set -o vi
function _update_ps1() {
    export PS1="$(~/powerline-shell-go -hostname-only-if-ssh -modules cwd -modules-right git $? 2> /dev/null)"
}

export LC_POWERLINE=1

### History related info

HISTSIZE=100000
export HISTTIMEFORMAT="%F %T "
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> "${HOME}/bash_logs/bash-history-$(date "+%Y-%m-%d").log"; fi;'
### ENDHISTORY
export PROMPT_COMMAND="$PROMPT_COMMAND _update_ps1"

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
source ~/dotfiles/bash_completion/pass

complete -d cd

function dlaudio {
  yt-dlp -f 'ba' -x --audio-format mp3 $1 -o '%(id)s.%(ext)s'
}


function fig {
  figlet -f banner $1 | sed -e"s/#/:$2:/g" | sed -e"s/ /:$3:/g" | pbcopy
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

function ts {
  args=$@
  tmux send-keys -t right "$args" C-m
}

function deps {
  bundle exec gem dependency $1 --reverse-dependencies
}
export BASH_SILENCE_DEPRECATION_WARNING=1
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
. "$HOME/.cargo/env"

 # eval "$(ssh-agent -s)"


SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add > /dev/null 2>&1;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent > /dev/null 2>&1
    }
else
    start_agent > /dev/null 2>&1
fi

export RESTIC_PASSWORD="'xaTF:JJ3n%n6,ti454HM!219"

gblame2 () {
    local file=$(fzf)
    cat "$file" | awk '{printf("%5d %s\n", NR, $0)}' | fzf --layout reverse --preview-window up --preview "echo {} | awk '{print \$1}' | xargs -I _ sh -c \"git log --color -L_,'+1:${file}'\""
}

fl () {
  branch="$(
  git branch --sort=-committerdate --format="%(committerdate:relative)%09%(refname:short)%09%(subject)" \
    | column -ts $'\t' \
    | fzf \
    | sed 's/.*ago \+\([^ ]*\) .*/\1/'
      )"
      git co $branch || (
      echo -n "git co $branch" | pbcopy
    )
  }
