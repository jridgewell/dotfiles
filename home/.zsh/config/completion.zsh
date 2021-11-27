unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

if type brew &>/dev/null; then
    local HOMEBREW_PREFIX="$(brew --prefix)"
    fpath=(
        $HOMEBREW_PREFIX/share/zsh-completions
        $HOMEBREW_PREFIX/share/zsh/site-functions
        $fpath
    )
fi

fpath=(
    ~/.zsh/completions
    $fpath
)

autoload -Uz compinit && compinit -i

compdef hub=git
