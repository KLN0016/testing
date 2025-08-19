alias mcs="make clean_sim"
alias rc="source /home/user16/work/klngan/.setup.csh"
alias s="source"
alias h="cd /home/user16/work/klngan/"
alias m="make"
alias ma="make all"
alias mc="make clean"
alias mb="make build"
alias mr="make run"
alias b="cd .."
alias bb="cd ../.."
alias rp="realpath"
alias lo="libreoffice"

# git
alias ga="git add"
alias gcm="git commit"
alias gpush="git push"
alias gp="git pull"
alias gs="git status"
alias gr="git restore"
alias gk="gitk"

alias repo="cd /home/user16/work/klngan/hdl_labs/repo/SPI-project && source spi.setup"
alias code="~/work/klngan/VSCode-linux-x64/code"

export SHELL_SCRIPT=~/work/klngan/.setup.csh
export PS1='\[\e[0;32m\][\u@\h \w]\$\[\e[0m\] '

function terminal_name() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}
alias tn="terminal_name"
