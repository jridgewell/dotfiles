# Custom open function
# Will open the current directory without parameters
# Or will open the passed parameters
function open1() {
    if [ $1 ]; then
        /usr/bin/open $@
    else
        /usr/bin/open .
    fi
}
