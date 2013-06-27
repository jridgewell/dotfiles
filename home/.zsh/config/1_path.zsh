typeset -aU path

# Only load PATH once
if [ -z $PATH_LOADED ]; then
    echo 'loading path'
    path=($HOME/.phpenv/bin $path)
    path=($HOME/.rbenv/bin $path)
    path=(/usr/local/bin /usr/local/sbin:$path)
    path=($HOME/bin $path)
    export PATH_LOADED="loaded!"
fi
