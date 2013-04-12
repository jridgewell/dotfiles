unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit -i
