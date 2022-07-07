export EDITOR=vim
export LANG=ja_JP.UTF-8
export LC_ALL=en_US.UTF-8  # Ubuntu-20 on WSL2 で問題が出たので設定

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

# alias dc=docker-compose
alias dc='docker compose'
alias be='docker compose run --rm app bundle exec'
alias dcr='docker compose run --rm app'

# neovim
alias vi='nvim'
alias vim='nvim'

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

# prompt
PS_INFO="$Green\w$Color_Off"
PS_GIT="$Yellow\$(parse_svn_branch)\$(parse_git_branch)$Color_Off"
export PS1="$PS_INFO $PS_GIT\n$ "

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

# git
if [ -f ~/completions/git-completion.bash ]; then
  . ~/completions/git-completion.bash
fi

# load files
if [ -d "$HOME/.bashrc.d" ]; then
  for sub_rc_script in ~/.bashrc.d/*; do
    source $sub_rc_script
  done
fi

complete -C /usr/local/Cellar/tfenv/2.0.0/versions/0.13.4/terraform terraform

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# Private bin directory
export PATH=$PATH:~/bin
