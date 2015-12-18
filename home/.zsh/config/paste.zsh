autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zle_highlight=(region:standout special:standout suffix:bold isearch:underline)
