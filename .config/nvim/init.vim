"===== Settings =====
" Misc
syntax enable
set cursorline
set scrolloff=5
set sidescrolloff=5
set number relativenumber
set history=200
set lazyredraw
set splitright
set splitbelow
set title
set timeoutlen=300
set updatetime=500
set hidden
set colorcolumn=100
set signcolumn=yes

" folding
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" autocompletion
set wildmenu
set wildmode=full
set completeopt=menu,menuone,noselect

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

" Persistant undo history
set undodir=~/.undodir/
set undofile

" leader
nnoremap <SPACE> <NOP>
let mapleader=" "
"===================


"===== Plugins =====
call plug#begin(stdpath('data') . '/plugged')
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
Plug 'smbl64/vim-black-macchiato'
Plug 'tpope/vim-abolish'
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'


Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'ray-x/lsp_signature.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

Plug 'dracula/vim'
call plug#end()
"===================


"===== Theme =====
set termguicolors
colorscheme dracula
lua vim.o.statusline='%#PmenuSel#%{StatuslineGit()}%#StatusLine# %f %m%r%h%w%=%y[%{&fileencoding?&fileencoding:&encoding}]    [%L,%3.p%%] %5.l:%-5.v'

"=================


"===== Plugins options =====
" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let tagbar_map_showproto="K"

" Fzf
let g:fzf_layout = { 'down': '40%' }

"===========================


"===== Autocommands =====
augroup format_on_save
    autocmd!
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

augroup python formatting
    autocmd FileType python xmap <buffer> <Leader>fo <plug>(BlackMacchiatoSelection)
    autocmd FileType python nnoremap <buffer> <Leader>iso :%!isort -<CR>
augroup END

augroup lightbulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
augroup END

highlight ExtraWhitespace ctermbg=red guibg=red
augroup trailing
    autocmd!
    autocmd BufNewFile,BufRead * :match ExtraWhitespace /\s\+$/
augroup END
"========================


"===== Functions =====
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

"Disable relative numbers if not focused
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

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
"================


"===== Mapping =====
" Fzf
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

" Custom
nnoremap <F2> :call ToggleDebugMode()<CR>
nnoremap <F12> :!ctags -R --fields=+Smt *<cr>
imap jk <Esc>

" Plugins
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFind<CR>
nnoremap <C-\> :TagbarToggle<CR>
nnoremap <F11> :UndotreeToggle<CR>
nmap [f [m
nmap ]f ]m

" Trailing spaces
nnoremap <leader>tr :%s/\s\+$//g<CR>

" Search for selected text in visual mode
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

" Insert line in normal mode
nmap oo m`o<Esc>``
nmap OO m`O<Esc>``

" Paste last yanked item
noremap <Leader>p "0p
noremap <Leader>P "0P

" Fix Y
nnoremap Y y$

" Backspace for previous buffer
nnoremap <bs> <c-^>

" Turn off fucking ex mode
nnoremap Q @q

" xml formatting
nnoremap <leader>xml :.!xmlstarlet fo<CR>
vnoremap <leader>xml :!xmlstarlet fo<CR>

" json formatting
nnoremap <leader>jq :.!jq .<CR>
vnoremap <leader>jq :!jq .<CR>

" Open / close tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" Opposite of J, split line
nnoremap S i<CR><ESC>k:sil! keepp s/\v +$//<CR>:set hls<CR>j^
"===================


"===== LSP STUFF =====
lua << EOF

-- Setup nvim-cmp.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require'cmp'
local luasnip = require("luasnip")

cmp.setup({
    completion = {
        autocomplete = false
    },
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = {
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if luasnip.expand_or_jumpable() then
           luasnip.expand_or_jump()
         else
           fallback()
         end
       end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
         else
           fallback()
        end
      end, { "i", "s" })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
       { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require("luasnip/loaders/from_vscode").load()



local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<leader>gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>gtd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.lsp.diagnostic.goto_prev({severity_limit = "Error"})<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.lsp.diagnostic.goto_next({severity_limit = "Error"})<CR>', opts)
  buf_set_keymap('n', '<leader>lld', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lle', '<cmd>lua vim.lsp.diagnostic.set_loclist({severity_limit= "Error"})<CR>', opts)
  buf_set_keymap("n", "<leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  if vim.inspect(client.name) ~= "\"pylsp\"" then
      buf_set_keymap("x", "<leader>fo", "<esc><cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  require'lsp_signature'.on_attach({
      extra_trigger_chars = {"(", ","},
      floating_window = false,
      toggle_key = '<C-h>',
      hi_parameter = 'IncSearch'
  })

end

require'lspconfig'.pylsp.setup{
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = false,
                }
            }
        }
    },
    on_attach = on_attach,
    capabilities = capabilities
}

require'lspconfig'.clangd.setup{
    on_attach = on_attach,
    capabilities = capabilities
}
require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities
}
require'lspconfig'.cmake.setup{on_attach = on_attach}

require "nvim-treesitter.configs".setup { highlight = {enable = true } }
EOF
"=====================

call SmartRelativeNumber(1)


" check help for all plugins
" split vimrc ?
" user guide
" blogs
" telescope?
" configure formatters (clang, python, etc)
" snippets

"lua << EOF
"vim.lsp.set_log_level("debug")
"EOF
