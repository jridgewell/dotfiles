unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

fpath=(
    ~/.zsh/completions
    /usr/local/share/zsh/site-functions
    /usr/local/share/zsh-completions
    $fpath
)
autoload -U compinit && compinit -i

compdef hub=git
