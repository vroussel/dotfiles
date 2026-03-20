#!/bin/bash

# Little script hack that launches a new xfce4-terminal with the
# current working directory as its default. Mimics pwdx with
# xfce4-terminal (all of whose windows share a single process for
# perfomance) by extracting the cwd from the window title.  If the
# ACTIVE_WINDOW isn't a xfce4-terminal, use pwdx of the current
# window's PID.
id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
class_string=$(xprop -id $id | awk '/WM_CLASS\(STRING\)/' | cut -d'=' -f2 | cut -d',' -f1)
if [ $class_string != '"xfce4-terminal"' ]
    then
        pid=$(xprop -id $id | awk '/_NET_WM_PID\(CARDINAL\)/' | cut -d'=' -f2)
        cwd=$(pwdx $pid | cut -d':' -f2 | cut -d' ' -f2)
    else
        name=$(xprop -id $id | awk '/_NET_WM_NAME/' | cut -d'"' -f2);
        _ssh=$(echo $name | grep -oP "(?<=ssh=)\S*")
        _pwd=$(echo $name | grep -oP "(?<=pwd=)\S*")
        _sudo=$(echo $name | grep -oP "(?<=sudo=)\S*")
fi

cwd=${_pwd:-$(echo $HOME)}
if [ -n "$_ssh" ]; then
    xfce4-terminal -x bash -c "SSHS_CWD=\"$cwd\" SSHS_SUDO_USER=\"$_sudo\" sshs $_ssh; bash"
else
    xfce4-terminal --working-directory "$cwd"
fi
