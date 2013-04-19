# Make directory and change into it.

function cdls() {
  cd "$1" && ls "$1";
}
