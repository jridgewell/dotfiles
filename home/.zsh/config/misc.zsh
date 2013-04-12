# Edit things in vim
export EDITOR=vim

##########################
### Language Specific ####
##########################
# Ruby
if [ $(which rbenv 2> /dev/null) ]; then
    initrbenv() {
        eval "$(rbenv init -)";
    }
fi
# Node.js
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
# Perl5
export PERL5LIB="/usr/local/share/perl5:$PERL5LIB"
