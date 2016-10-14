alias ls="ls -GphF"
alias be="bundle exec"
alias ber="bundle exec rake"
alias la="ls -la"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gcv="git commit -v"
alias bec='bundle exec cucumber --require features/'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias gmr="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short)'"
alias gdm='git branch --merged | grep -v "\*\|master\|deploy" | xargs -n 1 git branch -d'
alias gpf="git push --force-with-lease"
alias ginit="git init && git add . && git commit -m \"initial commit\""
alias gpo="git push origin master"
alias fixexif='find . -iname "P*.jpg" -print0 | xargs -0 exiftool -ImageDescription= -CameraID= -overwrite_original_in_place -P'
alias start_mysql='/usr/local/bin/mysql.server start'

unamestr=`uname -a`
if [[ "$unamestr" =~ 'Patricks-MacBook-Air' ]]; then
  alias start_postgres='pg_ctl -D /usr/local/var/postgres/postgres-9.5.1 -l /usr/local/var/postgres/server.log start'
fi
