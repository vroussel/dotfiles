"===== Settings =====
" Misc
syntax enable
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
set updatetime=500
set hidden
set clipboard=unnamedplus

" autocompletion
set wildmenu
set wildmode=full
set completeopt=menuone,noselect

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
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'ray-x/lsp_signature.nvim'
Plug 'kosayoda/nvim-lightbulb'

Plug 'dracula/vim'
call plug#end()
"===================

nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <C-P> :Files<CR>
nnoremap <leader>fif :Ag<CR>
nnoremap <leader>fw :Ag <c-r><c-w><CR>
nnoremap <leader>f<S-w> :Ag <c-r><c-a><CR>
nnoremap <leader>fib :Lines<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>o :History<CR>
nnoremap <leader>/ :History/<CR>
nnoremap <leader>: :History:<CR>

"===== Mapping =====
"Custom
set termguicolors
colorscheme dracula

imap jk <Esc>
nnoremap <F2> :call ToggleDebugMode()<CR>
nnoremap <F12> :!ctags -R --fields=+Smt *<cr>

"===== Mapping =====
" Plugins
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFind<CR>
nnoremap <C-\> :TagbarToggle<CR>
nnoremap <F11> :UndotreeToggle<CR>

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
nnoremap <C-A-k> <C-w>5+
nnoremap <C-A-j> <C-w>5-
nnoremap <C-A-h> <C-w>10<
nnoremap <C-A-l> <C-w>10>

" Persistant undo history
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Insert line in normal mode
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``

" Paste last yanked item
noremap <Leader>p "0p
noremap <Leader>P "0P

" Fix Y
nnoremap Y y$


"Debug mode (enable mouse + disable relative line numbers)
function! ToggleDebugMode()
    if !exists("b:debugmode")
        let b:debugmode = 0
    endif
    if b:debugmode == 0
        call SmartRelativeNumber(0)
        set norelativenumber
        set mouse=a
        let b:debugmode = 1
    else
        call SmartRelativeNumber(1)
        set relativenumber
        set mouse=""
        let b:debugmode = 0
    endif
endfunction

function! SmartRelativeNumber(val)
    let g:num_blacklist = ['nerdtree', 'tagbar']
    if a:val == 1
        augroup relativenumbertoggle
            autocmd!
            autocmd BufEnter,FocusGained,InsertLeave * if index(g:num_blacklist,&ft) == -1 | set relativenumber
            autocmd BufLeave,FocusLost,InsertEnter   * if index(g:num_blacklist,&ft) == -1 | set norelativenumber
        augroup END
    else
        augroup relativenumbertoggle
            autocmd!
        augroup END
        augroup! relativenumbertoggle
    endif
endfunction

call SmartRelativeNumber(1)


let g:tagbar_autoclose = 1
let g:tagbar_sort = 0

let tagbar_map_showproto="K"

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    --vsnip = true;
    --ultisnips = true;
  };
}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

   --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  require'lsp_signature'.on_attach()

end

require'lspconfig'.pylsp.setup{on_attach = on_attach}
require'lspconfig'.clangd.setup{
    on_attach = on_attach
}
require'lspconfig'.cmake.setup{on_attach = on_attach}


EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-u>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

augroup format_on_save
    autocmd!
    autocmd BufWritePre *.py,*.rs,CMakeLists.txt lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

augroup lightbulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
augroup END

let g:fzf_layout = { 'down': '40%' }

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

lua vim.o.statusline='%#PmenuSel#%{StatuslineGit()}%#StatusLine# %f %m%r%h%w%=%y[%{&fileencoding?&fileencoding:&encoding}]    [%L,%3.p%%] %5.l:%-5.v'

" folding
" check help for all plugins
" split vimrc ?
" user guide
" blogs
" telescope?
" clean up lsp / compe stuff
