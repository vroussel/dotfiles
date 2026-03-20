"===== Settings =====
" Misc
syntax enable
colorscheme badwolf
set nocompatible
set ttyfast
set nopaste
set cursorline
set scrolloff=3
set sidescrolloff=3
set number relativenumber
set foldmethod=indent
set foldlevel=99
set foldenable
set history=200
set lazyredraw
set splitright
set splitbelow
set title
set timeoutlen=300
set hidden

" autocompletion
set wildmenu
set wildmode=full

" indentation
set autoindent smartindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4

" encoding
set encoding=utf-8

" research
set hlsearch
set incsearch
set ignorecase
set smartcase

" leader
nnoremap <SPACE> <NOP>
let mapleader=" "
"===================


"===== Plugins =====
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/nacitar/a.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psf/black'
call plug#end()
"===================

imap jk <Esc>
nnoremap <F2> :call ToggleDebugMode()<CR>
nnoremap <F12> :!ctags -R --fields=+Smt *<cr>

"===== Mapping =====
" Plugins
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-\> :TagbarToggle<CR>
nnoremap <S-u> :UndotreeToggle<CR>

" Trailing spaces
nnoremap <leader>t :%s/\s\+$//g<CR>
highlight ExtraWhitespace ctermbg=red guibg=red
au BufNewFile,BufRead * :match ExtraWhitespace /\s\+$/

" Search for selected text in visual mode
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" fix & command to include flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" use tjump instead of tag with C-]
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" better grep
command! -nargs=+ Sgrep execute "silent grep! -r --exclude='tags' --exclude-dir=.git --exclude-dir=build --binary-files=without-match <args> . " | botright copen 25 | redraw!

" hard mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" switch pane without ctrl-w
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Window resizing
nnoremap <leader>k <C-w>5+
nnoremap <leader>j <C-w>5-
nnoremap <leader>h <C-w>5<
nnoremap <leader>l <C-w>5>
nnoremap <leader>kk <C-w>20+
nnoremap <leader>jj <C-w>20-
nnoremap <leader>hh <C-w>20<
nnoremap <leader>ll <C-w>20>
nnoremap <leader>= <C-w>=
nnoremap <leader>\| <C-w>\|
nnoremap <leader>_ <C-w>_

" Persistant undo history
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Insert line in normal mode
set completeopt-=preview
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``

" Paste last yanked item
noremap <Leader>p "0p
noremap <Leader>P "0P<Paste>

"Debug mode (enable mouse + disable relative line numbers)
function! ToggleDebugMode()
    if exists('#relativenumbertoggle')
        augroup relativenumbertoggle
            autocmd!
        augroup END
        augroup! relativenumbertoggle
        set norelativenumber
        set mouse=a
    else
        augroup relativenumbertoggle
            autocmd!
            autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
            autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
        augroup END
        set relativenumber
        set mouse=""
    endif
endfunction

augroup pythonfile
    autocmd!
    autocmd BufWritePre *.py Black
augroup END
