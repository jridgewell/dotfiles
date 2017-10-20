setopt PROMPT_SUBST

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
#SEGMENT_SEPARATOR='⮀'

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
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function is_vim_subshell() {
    if [[ -z $VIMRUNTIME ]]; then
        return 1; // not inside vim
    else
        return 0; // inside vim
    fi
}
function is_git_directory() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

function ps1_vim() {
    if is_vim_subshell; then
        prompt_segment default yellow "(vim)"
    fi
}
function ps1_git() {
    if is_git_directory; then
        local ref dirty
        dirty=$(parse_git_dirty)
        branch=$(git rev-parse --abbrev-ref HEAD)
        if [[ -n $dirty ]]; then
            prompt_segment yellow black
        else
            prompt_segment green black
        fi
        echo -n "$branch$dirty"
    fi
}
function ps1_path() {
    prompt_segment blue black "${PWD/#$HOME/~}"
}
function ps1_status() {
    local symbols
    symbols=()
    if [[ $RETVAL -ne 0 ]]; then
        symbols+="%{%F{red}%}✘"
    else
        symbols+="%{%F{green}%}✓"
    fi
    [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

function build_prompt() {
    RETVAL=$?
    local hostname=$HOSTNAME
    if [ -z $hostname ]; then
        hostname="%m"
    fi
    ps1_status
    prompt_segment black green "%n@$hostname"
    ps1_path
    ps1_vim
    ps1_git
    prompt_end
}

PROMPT='%{%f%b%k%s%u%}$(build_prompt) '
