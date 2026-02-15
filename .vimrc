" =========================
" Ronnie's Vim - Advanced
" =========================

" ---------- Basics ----------
set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set termguicolors
set hidden
set mouse=a
set updatetime=200
set timeoutlen=400

" ---------- UI ----------
set number
set relativenumber
set cursorline
set signcolumn=yes
set showcmd
set showmode
set laststatus=2
set ruler
set nowrap
set scrolloff=6
set sidescrolloff=6

" Better splits
set splitbelow
set splitright

" ---------- Indent ----------
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent

" ---------- Search ----------
set ignorecase
set smartcase
set incsearch
set hlsearch

" Clear search highlight with <Esc><Esc>
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" ---------- Clipboard ----------
" Use system clipboard when available
set clipboard=unnamedplus

" ---------- Undo ----------
set undofile
set undodir=~/.vim/undodir

" ---------- Wildmenu ----------
set wildmenu
set wildmode=longest:full,full

" ---------- Leader ----------
let mapleader=" "
let maplocalleader="\\"

" Quick save/quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Navigate wrapped lines nicely
nnoremap j gj
nnoremap k gk

" Keep selection after indenting in visual mode
vnoremap < <gv
vnoremap > >gv

" =========================
" Plugins (vim-plug)
" =========================
" Install vim-plug:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" Look & feel
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing helpers
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

" File tree
Plug 'preservim/nerdtree'

" Fuzzy finding (requires fzf binary)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Completion / LSP (requires node)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" =========================
" Theme / Airline
" =========================
set background=dark
colorscheme gruvbox

let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'

" =========================
" NERDTree
" =========================
nnoremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" =========================
" FZF
" =========================
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>

" Ripgrep integration (if rg installed)
if executable('rg')
  let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*"'
endif

" =========================
" GitGutter
" =========================
let g:gitgutter_enabled = 1

" =========================
" coc.nvim (LSP / completion)
" =========================
" Use Tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Diagnostics navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename
nmap <leader>rn <Plug>(coc-rename)

" Format
nmap <leader>fmt :call CocAction('format')<CR>

" Show documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Recommended: keep signcolumn on
set signcolumn=yes

" =========================
" Quality-of-life
" =========================
" Toggle relative numbers quickly
nnoremap <leader>n :set relativenumber!<CR>

" Auto-create undo dir
if !isdirectory(expand("~/.vim/undodir"))
  call mkdir(expand("~/.vim/undodir"), "p")
endif
