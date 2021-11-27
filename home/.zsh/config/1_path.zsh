typeset -aU path

# Only load PATH once
if [ -z $PATH_LOADED ]; then
    path=($HOME/homebrew/bin $path)
    path=($HOME/.nvm $path)
    path=($HOME/.cargo/bin $path)
    path=(/usr/local/bin /usr/local/sbin $path)
    path=($HOME/.zsh/bin $path)
    path=($HOME/bin $path)
    export PATH_LOADED="loaded!"
fi
