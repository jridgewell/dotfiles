if [[ ! -o interactive ]]; then
    return
fi

# Composer basic command completion
_composer_get_command_list() {
    composer --no-ansi | sed "1,/Available commands/d" | awk '/^ +[a-z]+/ { print $1 }'
}

_composer_get_option_list() {
    composer $1 --no-ansi --help | sed "1,/Options/d" | awk '/^ +--[a-z]+/ { print $1 }'
}

compctl -K _composer composer

_composer() {
    local words completions
    read -cA words

    if [ "${#words}" -eq 2 ]; then
        completions="$(_composer_get_command_list)"
    else
        completions="$(_composer_get_option_list ${words[2,-2]})"
    fi

    if [ -f composer.json ]; then
        reply=("${(ps:\n:)completions}")
    else
        reply=(
        "create-project"
        "init"
        "search"
        "selfupdate"
        "show"
        )
    fi
}
