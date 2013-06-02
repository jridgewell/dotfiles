# Shortcut for tmux attach.
# If no session is specified, default
# to the current directory
function tat() {
    local session=${1:=${PWD##*/}}
    tmux has -t $session && tmux attach -t $session || tmux new -s $session
}

function __tmux-sessions() {
    local expl
    local -a sessions
    sessions=( ${${(f)"$(command tmux list-sessions)"}/:[ $'\t']##/:} )
    _describe -t sessions 'sessions' sessions "$@"
}

compdef __tmux-sessions tat
