# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

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
