if is-callable hub; then
    alias git='hub'
fi
alias open='open1'
alias ll='ls -lhAF'
alias ..='cd ..'
alias -- -='cd -'
alias rmdsstore='find . \( -name '.DS_Store' \)  -exec rm {} \;'
alias arsync='rsync'
alias arcsync='rsync --checksum'
alias rsync='rsync --human-readable --verbose --progress --partial --stats --compress --recursive --times --perms --copy-links --exclude ".DS_Store"'
alias cleanopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; killall Finder'
alias tat='tmux attach -t `basename $PWD`'
alias tnew='tmux new -s `basename $PWD`'
