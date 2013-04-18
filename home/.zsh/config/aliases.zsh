if [[ $(which hub 2> /dev/null) == 0 ]]; then
    alias git='hub'
fi
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
alias tat='tmux attach -t `basename $PWD`'
