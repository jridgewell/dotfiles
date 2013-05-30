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
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
# Perl5
export PERL5LIB="/usr/local/share/perl5:$PERL5LIB"
