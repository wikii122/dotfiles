HISTFILE=~/.histfile
DIRSTACKFILE=/tmp/zsh_dirs
HISTSIZE=2000
SAVEHIST=2000
DIRSTACKSIZE=21

bindkey -e

autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors

# treate a zkbd compatible hash;
# to add other keys to this hash.
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.

bindkey "OA" history-beginning-search-backward
bindkey "OB" history-beginning-search-forward

# Switch some useful options
setopt inc_append_history
setopt autocd 
setopt nomatch 
setopt completealiases 
setopt correctall
setopt extended_glob
setopt no_case_glob
setopt autopushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt pushd_minus
setopt glob_dots

unsetopt beep 
unsetopt notify

# History enhancing
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt bang_hist
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt complete_aliases

# csh like loops
setopt csh_junkie_loops

# Emacs bindings in global config
# bindkey -e
#

# Theme
prompt walters
#PROMPT="%{$fg[reset_color]%}[%n@%M %#]$ " 
autoload zargs

compctl -c .

# Completion settings - some magic
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:::::' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 2
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete # Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST # Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes' # Include non-hidden directories in globbed file completions

# Enviromental variales
export EDITOR="vim"

# Aliases
alias ls="ls --color"
alias pacman="sudo pacman"
alias uri="xdg-open"
alias aptitude="sudo aptitude"
alias dir="dir -x --color --almost-all --escape --classify --group-directories-first --human-readable -l"
alias todo="todo.sh"
compdef todo="todo.sh"

# Nocorrect
alias sudo='nocorrect sudo'
alias workon="nocorrect workon"

# For history ignore
alias dirs=" dirs"
alias history=" history"
alias clear=" clear"
#alias get="yaourt -S"

#Suffix aliases
alias -s cpp=vim
alias -s c=vim
alias -s hpp=vim
alias -s h=vim
alias -s txt=cat
alias -s html=chromium
alias -s session="vim -S"

# Python virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export PIP_RESPECT_VIRTUALENV=true
#source /usr/local/bin/virtualenvwrapper.sh 
#source /etc/bash_completion.d/virtualenvwrapper
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

# Ruby bundler
#export GEM_HOME=~/.gem/ruby/2.0.0
source /home/wilo/.rvm/scripts/rvm

#Go
export GOPATH=/home/wilo/Projects/Go 

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{3}-%F{2}%b%F{5})%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git cvs svn bzr

# Command not found hook
[[ -r /etc/zsh_command_not_found ]] && . /etc/zsh_command_not_found

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
  echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}

PROMPT="%{$fg[reset_color]%}[%n@%M "$'$(vcs_info_wrapper)'"%#]$ " 
# dirstack save/load
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

#if [[ -r /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#	source /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh
#fi
