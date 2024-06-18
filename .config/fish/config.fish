set -gx SHELL /bin/fish

# Necessary because default are wide glyphs
# wide glyphs don'g appear in urxvt
set -g ___fish_git_prompt_char_cleanstate ""
set -g ___fish_git_prompt_char_dirtystate ""
set -g ___fish_git_prompt_char_invalidstate ""
set -g ___fish_git_prompt_char_stashstate ""

source ~/.aliases

alias d cdh
bind \cz 'fg 2>/dev/null; commandline -f repaint'
