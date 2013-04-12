##########################
# Source Machine Specific#
##########################
if [ -d "$HOME/.zsh" ]; then
    for f in "$HOME/.zsh/"*; do
        source $f
    done
fi

##########################
### Path #################
##########################
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

##########################
### Language Specific ####
##########################
# Ruby
if [ $(which rbenv 2> /dev/null) ]; then
    initrbenv() {
        eval "$(rbenv init -)";
    }
fi
# Node.js
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
# Perl5
export PERL5LIB="/usr/local/share/perl5:$PERL5LIB"

##########################
### iOS Dev ##############
##########################
export THEOS=/opt/theos
export PATH="$PATH:$THEOS/bin:$THEOS/sbin"
# export SDKVERSION=5.0
export THEOS_DEVICE_IP=Mort.local

export iOSOpenDevPath=/opt/iOSOpenDev
export iOSOpenDevDevice=Mort.local
export PATH="$PATH:$iOSOpenDevPath/bin"

##########################
### Aliases ##############
##########################
if [ $(which hub 2> /dev/null) ]; then alias git='hub'; fi
alias open='open1'
alias ll='ls -lhAF'
alias ..='cd ..'
alias -- -='cd -'
alias rmdsstore='find . \( -name '.DS_Store' \)  -exec rm {} \;'
alias arsync='rsync'
alias arcsync='rsync --checksum'
alias msync='arcsync --include "*/" --include="*.mp3" --include="*.flac" --exclude "*" ridgewell.name:/torrent/tmp/* ~/Desktop; ssh ridgewell.name rm /torrent/tmp/* -f'
alias rsync='rsync --human-readable --verbose --progress --partial --stats --compress --recursive --times --perms --copy-links --exclude ".DS_Store"'
alias cleanopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder'

##########################
### Completions ##########
##########################
fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit -i

##########################
### Misc #################
##########################
# Stop .mac files
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

# History
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify

# Edit things in vim
export EDITOR=vim

##########################
### Terminal Colors ######
##########################
autoload -U colors && colors

##########################
#### PS1 #################
##########################
CURRENT_BG='NONE'
#SEGMENT_SEPARATOR='\u25B6'
SEGMENT_SEPARATOR='⮀'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

function parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
function parse_git_path_relative_to_root() {
    local path_relative=$(git rev-parse --show-prefix)
    local path=$(git rev-parse --show-toplevel)
    path_relative=${path_relative+/$path_relative}
    echo -n "${path##*/}${path_relative%%/}"
}
function is_vim_subshell() {
    if [[ -z $vimruntime ]]; then
        return 1; // not inside vim
    else
        return 0; // inside vim
    fi
}
function is_git_directory() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

function vim_ps1() {
    if is_vim_subshell; then
        echo -en " %{$fg[yellow]%}(vim)%{$reset_color%}"
    fi
}
function ps1_git() {
    if is_git_directory; then
        local ref dirty
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        if [[ -n $dirty ]]; then
            prompt_segment yellow black
        else
            prompt_segment green black
        fi
        echo -n "${ref/refs\/heads\//⭠}$dirty"
    fi
}
function ps1_path() {
    prompt_segment blue black "${PWD/#$HOME/~}"
}
function ps1_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
    [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

function build_prompt() {
    RETVAL=$?
    ps1_status
    prompt_segment black green "%n@%m"
    #prompt_segment default default "in"
    ps1_path
    ps1_git
    prompt_end
}

export RENAME_TITLE="\033]0;\u@\h\007"
#export PROMPT="%{$fg[green]%}%n@%m%{$reset_color%}$(vim_ps1) in $(path_ps1)$(git_ps1)\$%{$reset_color%} "
PROMPT='%{%f%b%k%}$(build_prompt) '
setopt PROMPT_SUBST
