export GOPATH=$HOME/go
export PATH=$PATH:~/bin:$GOPATH/bin:~/Library/Android/sdk/tools:~/Library/Android/sdk/platform-tools:~/Library/Android/sdk/build-tools/21.1.2
export ANDROID_HOME=~/Library/Android/sdk
export EDITOR=vim
export LANG=ja_JP.UTF-8

#
# Colors
# from : https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#

Color_Off='\e[0m'       # Text Reset

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

#
# aliases
#

alias dc=docker-compose
alias be='docker-compose exec app bundle exec'

#
# parse SVN branch
#

parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | sed -e 's#^/##g' | sed -e 's#^branches/##g' | sed -e 's#^tags/##g' | sed -e 's#^private/##g' | sed -e 's#\([^/]*\)/.*#\1#' | awk '{print " (svn:"$1")" }'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

#
# parse Git branch
#
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) =~ "^nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

function ps_fill {
  ps_line=$(printf -- '- %.0s' {1..400})
  cols=$(tput cols)
  printf ${ps_line:0:$cols}
}


# prompt
PS_LINE=$(printf -- '- %.0s' {1..400})
COLS=$(tput cols)
PS_FILL=${PS_LINE:0:$COLS}
PS_INFO="$Green\h:\W$Color_Off"
PS_GIT="$Yellow\$(parse_svn_branch)\$(parse_git_branch)$Color_Off"
PS_TIME="\e[\$((COLS-10))G\] $Red[\t]$Color_Off"
# export PS1="$Green\h:\W$Yellow\$(parse_svn_branch)\$(parse_git_branch)$Color_Off $ "
export PS1="$PS_INFO$PS_GIT\n$ "

# colordiff -> diff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# less color enabled
export LESS='-R'

# ----------------------
# enable bash_completion
# ----------------------

# Homebrew packages
if [ -x "$(command -v brew)" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# tmuxinator
source $(dirname $(dirname $(gem which tmuxinator)))/completion/tmuxinator.bash

# git
if [ -f ~/completions/git-completion.bash ]; then
  . ~/completions/git-completion.bash
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# # for NVM
# source ~/.bash
#
# # for rbenv
# source ~/.bashrc.d/rbenv
#
# # for pyenv
# source ~/.bashrc.d/pyenv
#
# # for AWS
# source ~/.bashrc.d/aws
#
# # for Oracle Instant Client
# source ~/.bashrc.d/oracle
#
# # load secrets
# source ~/.bashrc_secrets
#
# # for Java
# source ~/.bashrc.d/java
for sub_rc_script in ~/.bashrc.d/*; do
  source $sub_rc_script
done
