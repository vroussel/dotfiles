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
set laststatus=3

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
" Telescope / fzf
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP / completion
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'kosayoda/nvim-lightbulb'

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Visual stuff
Plug 'dracula/vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'b0o/incline.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" Tags
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

" Misc
Plug 'https://github.com/nacitar/a.vim'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'smbl64/vim-black-macchiato'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'yssl/QFEnter'
"Plug 'nvim-treesitter/playground'
call plug#end()
"===================

"===== Theme =====
set termguicolors
colorscheme dracula
highlight IndentBlanklineSpaceChar guifg=#666666 gui=nocombine
highlight IndentBlanklineChar guifg=#666666 gui=nocombine
lua << EOF
require('incline').setup()
require("lualine").setup({
	sections = {
			lualine_c = {
                { 'filename', path = 3}
			}
	}
})
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
             'for',
             'while',
             'if',
            -- 'switch',
            -- 'case',
        },
    },
}
EOF
"=================


"===== Plugins options =====
" Tagbar
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let tagbar_map_showproto="K"
"===========================


"===== Autocommands =====
augroup format_on_save
    autocmd!
    autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)
augroup END

augroup python formatting
    autocmd FileType python xmap <buffer> <Leader>fo <plug>(BlackMacchiatoSelection)
    autocmd FileType python nnoremap <buffer> <Leader>fi :%!isort -<CR>
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

augroup relativenumbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number == 1 | set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number == 1 | set norelativenumber
augroup END
"========================


"===== Functions =====
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction
"================


"===== Mapping =====
" Telescope / fzf
nnoremap <leader><tab> :Telescope keymaps<CR>
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fz :Rg<CR>
nnoremap <leader>fw :Telescope grep_string<CR>
nnoremap <leader>b :Telescope buffers<CR>
nnoremap <leader>o :Telescope oldfiles<CR>
nnoremap <leader>/ :Telescope search_history<CR>
nnoremap <leader>: :Telescope command_history<CR>
nnoremap <leader>tr :Telescope resume<CR>

" conflig resolving with fugitive
nnoremap <leader>gs :G <CR>
nnoremap <leader>df :diffget //2<CR>
nnoremap <leader>dj :diffget //2<CR>

" Custom
nnoremap <F12> :!ctags -R --fields=+Smt *<cr>
imap jk <Esc>

" Plugins
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>ntf :NERDTreeFind<CR>
nnoremap <C-\> :TagbarToggle<CR>
nnoremap <F11> :UndotreeToggle<CR>
nnoremap <leader>se :LuaSnipEdit<CR>
nnoremap <F10> :lua require('incline').toggle()<CR>
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" Trailing spaces
nnoremap <leader>ts :%s/\s\+$//g<CR>

" Search for selected text in visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" fix & command to include flags
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" use tjump instead of tag with C-]
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

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

" Paste from system clipboard
noremap <Leader><Leader>y "+y
vnoremap <Leader><Leader>y "+y
noremap <Leader><Leader>p "+p
noremap <Leader><Leader>P "+P

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
local cmp = require'cmp'
local luasnip = require("luasnip")
local lspkind = require('lspkind')

cmp.setup({
    snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(function()
          if luasnip.choice_active() then
              require("luasnip.extras.select_choice")()
          else
              cmp.mapping.complete()
          end
      end, { 'i', 'c' }),
      ['<C-y>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
      },
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<C-j>"] = cmp.mapping(function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
       end, { "i", "s" }),
      ["<C-k>"] = cmp.mapping(function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { "i", "s" }),
      ["<C-l>"] = cmp.mapping(function()
        if luasnip.choice_active() then
          luasnip.change_choice(1)
        end
      end, { "i", "s" }),
      ["<C-h>"] = cmp.mapping(function()
        if luasnip.choice_active() then
          luasnip.change_choice(-1)
        end
      end, { "i", "s" }),
      ['<C-s>'] = cmp.mapping.complete({
        config = {
          sources = {
            { name = 'luasnip' }
          }
        }
      })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp', keyword_length = 3 },
      { name = 'nvim_lua', keyword_length = 3 },
      { name = 'luasnip', keyword_length = 3 },
      { name = 'path' },
    }, {
      { name = 'buffer', keyword_length = 5 },
    }),
    experimental = {
        ghost_text = true,
    },
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        with_text = true,
        menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path = "[path]",
            luasnip = "[snip]",
            cmdline = "[cmd]"
        },
      })
    }
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
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>gd', '<Cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>gt', '<Cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', '<leader>gi', '<Cmd>Telescope lsp_implementations<CR>', opts)
  buf_set_keymap('n', '<leader>gr', '<cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>sig', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap("x", "<leader>ca", '<esc><cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>dia', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev({severity = "Error"})<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next({severity = "Error"})<CR>', opts)
  buf_set_keymap('n', '<leader>lsd', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
  buf_set_keymap('n', '<leader>lse', '<cmd>lua vim.diagnostic.setqflist({severity = "Error"})<CR>', opts)
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
require'lspconfig'.cmake.setup{
    on_attach = on_attach,
    capabilities = capabilities
}


require "nvim-treesitter.configs".setup { highlight = {enable = true } }

local telescope = require'telescope'
local actions = require("telescope.actions")
telescope.load_extension('fzf')
telescope.setup({
    defaults = {
        preview = {
            treesitter = false,
        },
        mappings = {
            i = {
                ["<esc>"] = actions.close
            },
        },
    },
})

-- Snippets
luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    region_check_events = "InsertEnter",
	delete_check_events = "TextChanged,InsertLeave"
}
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({paths = "./snippets"})
require("luasnip.loaders.from_lua").lazy_load({paths = "./snippets"})
vim.api.nvim_create_user_command("LuaSnipEdit", 'lua require("luasnip.loaders").edit_snippet_files()', {})


EOF
"=====================

" check help for all plugins
" split vimrc ?
" user guide
" blogs
" configure formatters (clang, python, etc)
" snippets
" TJ videos
" diaglist
" https://github.com/rockerBOO/awesome-neovim#neovim-lua-development
" https://neovimcraft.com/

"lua << EOF
"vim.lsp.set_log_level("debug")
"EOF
