# Edit things in vim
export EDITOR=vim

##########################
### Language Specific ####
##########################
# Ruby
if is-callable rbenv; then
    eval "$(rbenv init -)";
fi
# PHP
if is-callable phpenv; then
    eval "$(phpenv init -)";
fi
# Node.js
if is-callable nvm-exec; then
    source ~/.nvm/nvm.sh
else
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
fi
# Perl5
export PERL5LIB="/usr/local/share/perl5:$PERL5LIB"
