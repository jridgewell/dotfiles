# Exit if non-interactive
if [ -z "$PS1" ]; then
   return
fi

##########################
### Path #################
##########################
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

##########################
### Language Specific ####
##########################
# JAVA
export CLASSPATH="/usr/share/java/junit-4.8.2/junit.jar:/usr/share/java/junit-4.8.2/:$CLASSPATH"
# Ruby
if [ $(which rbenv 2> /dev/null) ]; then eval "$(rbenv init -)"; fi
# Node.js
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"


##########################
### iOS Dev ##############
##########################
export THEOS=/opt/theos
export PATH="$PATH:/opt/theos/bin:/opt/theos/sbin"
# export SDKVERSION=5.0
export THEOS_DEVICE_IP=Kryptonite.local


##########################
### Aliases ##############
##########################
if [ $(which hub 2> /dev/null) ]; then alias git='hub'; fi
alias open='open1'
alias mkdir='mkd'
alias ll='ls -lhAF'
alias ..='cd ..'
alias -- -='cd -'
alias rmdsstore='find . \( -name '.DS_Store' \)  -exec rm {} \;'
alias msync='arcsync --include "*/" --include='*.mp3' --include='*.flac' --exclude "*" ridgewell.name:/torrent/tmp/* ~/Desktop; ssh ridgewell.name rm /torrent/tmp/* -f'
alias arsync='rsync --human-readable --verbose --progress --partial --stats --compress --recursive --times --perms --copy-links --exclude ".DS_Store"'
alias arcsync='rsync --human-readable --checksum --verbose --progress --partial --stats --compress --recursive --times --perms --copy-links --exclude ".DS_Store"'
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
if [ $(which brew 2> /dev/null) ]; then
	if [ -f `brew --prefix`/etc/bash_completion ]; then
		. `brew --prefix`/etc/bash_completion
	fi
fi
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi



##########################
### Terminal Colors ######
##########################
if tput setaf 1 &> /dev/null; then
	tput sgr0
	RED="\[$(tput setaf 1)\]"
	GREEN="\[$(tput setaf 2)\]"
	BLUE="\[$(tput setaf 4)\]"
	BOLD="\[$(tput bold)\]"
	RESET="\[$(tput sgr0)\]"
	# BLACK="\[$(tput setaf 0)\]"
	# YELLOW="\[$(tput setaf 3)\]"
	# MAGENTA="\[$(tput setaf 5)\]"
	# CYAN="\[$(tput setaf 6)\]"
	# WHITE="\[$(tput setaf 7)\]"
else
	RED="\[\033[0;31m\]"
	GREEN="\[\033[0;32m\]"
	BLUE="\[\033[0;34m\]"
	BOLD=""
	RESET="\[\033[m\]"
	# BLACK="\[\033[0;30m\]"
	# YELLOW="\[\033[0;33m\]"
	# MAGENTA="\[\033[0;35m\]"
	# CYAN="\[\033[0;36m\]"
	# WHITE="\[\033[0;37m\]"
fi
export RED
export GREEN
export BLUE
export BOLD
export RESET
# export BLACK
# export YELLOW
# export MAGENTA
# export CYAN
# export WHITE

##########################
### Functions ############
##########################
parse_git_dirty() {
    [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}
parse_git_path_relative_to_root() {
	local path_relative=$(git rev-parse --show-prefix | sed -e 's/\/$//' -e 's/\(.\)/\/\1/')
	git rev-parse --show-toplevel | sed -e "s|.*\/\([^/]*\)$|\1$path_relative|"
}

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
    currFolderPath=$( /usr/bin/osascript <<"    EOT"
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


# PS1
export RENAME_TITLE="\033]0;\u@\h\007"
export PS1="${RENAME_TITLE}${BOLD}${GREEN}\u${RESET} in ${BOLD}${BLUE}\$( if [ \$(git rev-parse --show-toplevel 2> /dev/null) ]; then echo \"\$(parse_git_path_relative_to_root)${RESET} on ${BOLD}${RED}\$(parse_git_branch) ${RESET}${RED}\"; else echo \"\w${RESET}${BLUE}\"; fi)\n\$${RESET} "
