# Exit if non-interactive
if [ -z "$PS1" ]; then
   return
fi


##########################
# Source Machine Specific#
##########################
if [ -d "$HOME/.bash" ]; then
    for f in "$HOME/.bash/"*; do
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
alias mcd='mkd'
alias ll='ls -lhAF'
alias ..='cd ..'
alias -- -='cd -'
alias rmdsstore='find . \( -name '.DS_Store' \)  -exec rm {} \;'
alias arsync='rsync'
alias arcsync='rsync --checksum'
alias rsync='rsync --human-readable --verbose --progress --partial --stats --compress --recursive --times --perms --copy-links --exclude ".DS_Store"'
alias cleanopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder'


##########################
### Misc #################
##########################
# Stop .mac files
export COPYFILE_DISABLE=true
export COPY_EXTENDED_ATTRIBUTES_DISABLE=true

# History
export HISTIGNORE="&:[ ]*:exit"
shopt -s histverify

# Edit things in vim
export EDITOR=vim

# Bash Completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ $(which brew 2> /dev/null) ]; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi
if [ -d "$HOME/.bash-completions" ]; then
    for f in "$HOME/.bash-completions"/*; do
        . "$f"
    done
fi


##########################
### Functions ############
##########################
# Custom open function
# Will open the current directory without parameters
# Or will open the passed parameters
open1() {
    if [[ $1 ]]; then
        /usr/bin/open $1
    else
        /usr/bin/open .
    fi
}

# I hate expansion
_expand() {
    return 0;
}

# Create the directory then cd to it
mkd() {
    /bin/mkdir -p "$@" && cd "$@"
}

# cd to frontmost finder folder
cdf() {
    local currFolderPath=$( /usr/bin/osascript <<"    EOT"
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to home folder as alias)
            end try
            POSIX path of currFolder
        end tell
    EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath";
}

# Extract an archive
# https://raw.github.com/revans/bash-it/master/plugins/available/extract.plugin.bash
extract () {
    if [ $# -ne 1 ]; then
        echo "Error: No file specified."
        return 1
    fi
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


##########################
### Terminal Colors ######
##########################
#if tput setaf 1 &> /dev/null; then
    #tput sgr0
    #RED="\001$(tput setaf 1)\002"
    #GREEN="\001$(tput setaf 2)\002"
    #BLUE="\001$(tput setaf 4)\002"
    #BOLD="\001$(tput bold)\002"
    #RESET="\001$(tput sgr0)\002"
    #BLACK="\001$(tput setaf 0)\002"
    #YELLOW="\001$(tput setaf 3)\002"
    #MAGENTA="\001$(tput setaf 5)\002"
    #CYAN="\001$(tput setaf 6)\002"
    #WHITE="\001$(tput setaf 7)\002"
#else
    RED="\001\033[0;31m\002"
    GREEN="\001\033[0;32m\002"
    BLUE="\001\033[0;34m\002"
    BOLD="\001\033[1m\002"
    RESET="\001\033[m\002"
    BLACK="\001\033[0;30m\002"
    YELLOW="\001\033[0;33m\002"
    MAGENTA="\001\033[0;35m\002"
    CYAN="\001\033[0;36m\002"
    WHITE="\001\033[0;37m\002"
#fi
export RED
export GREEN
export BLUE
export BOLD
export RESET
export BLACK
export YELLOW
export MAGENTA
export CYAN
export WHITE


##########################
#### PS1 #################
##########################
parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
parse_git_path_relative_to_root() {
    local path_relative=$(git rev-parse --show-prefix)
    local path=$(git rev-parse --show-toplevel)
    path_relative=${path_relative+/$path_relative}
    echo -n "${path##*/}${path_relative%%/}"
}
is_vim_subshell() {
    if [[ -z $VIMRUNTIME ]]; then
        return 1; // NOT INSIDE VIM
    else
        return 0; // INSIDE VIM
    fi
}
is_git_directory() {
    git rev-parse --show-toplevel &> /dev/null
}

vim_ps1() {
    if is_vim_subshell; then
        echo -en " ${YELLOW}(VIM)${RESET}"
    fi
}
path_ps1() {
    echo -en "${BLUE}${BOLD}"
    if is_git_directory; then
        echo -en "$(parse_git_path_relative_to_root)${RESET} on ${RED}${BOLD}$(parse_git_branch) ${RESET}${RED}"
    else
        echo -en "${PWD/$HOME/~}${RESET}${BLUE}"
    fi
}

export RENAME_TITLE="\033]0;\u@\h\007"
#export PS1="${RENAME_TITLE}${BOLD}${GREEN}\u@\h${RESET}\$(vim_ps1) in \$(path_ps1)\n\$${RESET} "
export PS1="${RENAME_TITLE}${GREEN}${BOLD}\u@\h${RESET}\$(vim_ps1) in \$(path_ps1)\r\n\$${RESET} "
