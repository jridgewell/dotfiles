# make search up and down work, so partially type and hit up/down to find relevant stuff
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Alt + ArrowKeys
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# Emacs Ctrl-A and Ctrl-E
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char
