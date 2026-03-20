#!/bin/bash
WHEREAMI=$(cat ${XDG_RUNTIME_DIR}/.cwd)
echo$WHEREAMI
i3-sensible-terminal --working-directory="$WHEREAMI"
