#!/bin/sh

win_id=$(i3-msg -t get_tree | jq 'recurse(.nodes[]) | select(.layout=="tabbed").nodes[] | select([recurse(.nodes[]).focused] | any).id')
i3-msg [con_id="$win_id"] focus
i3-msg focus "$@"
