# Shortcut for tmux attach.
# If no session is specified, default
# to the current directory
function tat() {
    tmux attach -t ${1:=`basename $PWD`}
}
