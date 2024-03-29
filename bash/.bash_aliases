alias ls="exa"
alias be="bundle exec"
alias ber="bundle exec rake"
alias berc="bundle exec rails console"
alias la="exa -la -snew"
alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gco="git checkout"
alias vi="vim"
alias gcv="git commit -v"
alias bec='bundle exec cucumber --require features/'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias gdm='git branch --merged | rg --invert-match  "(^[\s]+(master|main|deploy)$|[*])" | xargs -n 1 git branch -d'
alias gpf="git push --force-with-lease"
alias ginit="git init && git add . && git commit -m \"initial commit\""
alias gpo="git push origin master"
alias gdc="git diff --cached"
alias gca="git commit --amend"
alias ack="rg"
alias fixexif='find . -iname "P*.jpg" -print0 | xargs -0 exiftool -ImageDescription= -CameraID= -overwrite_original_in_place -P'
alias start_mysql='/usr/local/opt/mysql\@5.7/bin/mysql.server start'
alias vimu='vim $(git ls-files --modified --others --exclude-standard)'
alias help="tldr"
alias ping="prettyping --nolegend"
alias m="git checkout master"
alias aoc="cd ~/sites/advent_of_code/2021"
alias youtube-dl="yt-dlp"

unamestr=`uname -a`
if [[ "$unamestr" =~ 'Patricks-MacBook-Air' ]]; then
  alias start_postgres='pg_ctl -D /usr/local/var/postgres/postgres-9.5.1 -l /usr/local/var/postgres/server.log start'
else
  alias start_postgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
fi
alias serve="ruby -run -e httpd . -p 5000"
alias gh='git config --get remote.origin.url | ruby -ne "puts %{https://github.com/#{\$_.split(/.com[\:\/]/)[-1].gsub(%{.git},%{})}}"| xargs open'
