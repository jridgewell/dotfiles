# Edit things in vim
export EDITOR=vim

##########################
### Language Specific ####
##########################
# Node.js
if is-callable nvm-exec; then
    export NVM_DIR="$HOME/.nvm"
    # source "$NVM_DIR/nvm.sh"
    lazy_load_nvm() {
        unset -f node npm npx yarn nvm
        [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
    }

    node() {
        lazy_load_nvm
        node $@
    }
    npm() {
        lazy_load_nvm
        npm $@
    }
    npx() {
        lazy_load_nvm
        npx $@
    }
    yarn() {
        lazy_load_nvm
        yarn $@
    }
    nvm() {
        lazy_load_nvm
        nvm $@
    }
else
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
fi
