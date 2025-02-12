#!/usr/bin/env sh

# This script was made by `goferito` on Github.
# Some cleanup by Luke.

[ -z "$1" ] && echo "No direction provided" && exit 1
[ -z "$2" ] && echo "No distance provided" && exit 1
distanceStr="$2"

moveChoice() {
  i3-msg resize "$1" "$2" "$distanceStr" | grep '"success":true' ||     i3-msg resize "$3" "$4" "$distanceStr"
}

case $1 in
  up)
    moveChoice shrink down grow up
    ;;
  down)
    moveChoice grow down shrink up
    ;;
  left)
    moveChoice shrink right grow left
    ;;
  right)
    moveChoice grow right shrink left
    ;;
esac
