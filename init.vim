" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

" lang support
Plug 'rust-lang/rust.vim'
Plug 'derekwyatt/vim-scala'
Plug 'neovimhaskell/haskell-vim'

Plug 'lervag/vimtex'
Plug 'neomake/neomake'
Plug 'parsonsmatt/intero-neovim'
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille'

Plug 'ntpeters/vim-better-whitespace'
Plug 'terryma/vim-multiple-cursors'

" syntax checking
Plug 'vim-syntastic/syntastic'

" searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" movement
Plug 'justinmk/vim-sneak'
Plug 'christoomey/vim-tmux-navigator'

" commenting
Plug 'scrooloose/nerdcommenter'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" finances
Plug 'ledger/vim-ledger'

" eye candies
Plug 'itchyny/lightline.vim'
Plug 'dracula/vim'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-sayonara'

call plug#end()


"
" Settings
"
" many of these are from @jessfraz's vimrc

set noerrorbells
set number
set backspace=indent,eol,start
set showcmd

set noswapfile
set nobackup
set nowritebackup
set splitbelow
set splitright
set encoding=utf-8
set autowrite
set autoread
set laststatus=2
set hidden

set ruler
au FocusLost * :wa

set fileformats=unix,dos,mac

set noshowmode
set incsearch
set hlsearch
set ignorecase
set smartcase
set lazyredraw

set nocursorcolumn
set nocursorline

syntax sync minlines=256
set re=1

set conceallevel=0

set wrap
set textwidth=79
set formatoptions=qrn1

au BufRead /tmp/mutt-* set tw=72

set autoindent
set complete-=i
set showmatch
set smarttab
set cpo+=J
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nrformats-=octal
set shiftround

set notimeout
set ttimeout
set ttimeoutlen=10

" better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone

set scrolloff=2
set sidescrolloff=5
set display+=lastline

if has('mouse')
    set mouse=a
endif

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
else
endif

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
endif


set termguicolors
colorscheme dracula


let mapleader = "\<Space>"
let maplocalleader = "\\"
nnoremap j gj
nnoremap k gk
nnoremap <leader>fs :w<CR>
nnoremap <leader>fed :vsplit $MYVIMRC<CR>

autocmd FileType qf wincmd J

" allow saving of files when forgot to use sudo
cmap w!! w !sudo tee > /dev/null %

nnoremap <silent> <leader>q :Sayonara<CR>

" package management
nnoremap <leader>pi :PlugInstall<CR>
nnoremap <leader>pu :PlugUpdate<CR>
nnoremap <leader>pc :PlugClean<CR>
nnoremap <leader>pd :PlugDiff<CR>
command! PU :PlugUpgrade | PlugUpdate
nnoremap <leader>pU :PU<CR>

" git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gp :Gpush<CR>

" searching
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files ~<CR>
nnoremap <leader>fr :History<CR>

" buffers
nnoremap <leader>bl :Buffers<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l


"
" filetype settings
"

augroup tamarin
    au BufNewFile,BufRead *.spthy setf spthy
    au BufNewFile,BufRead *.sapic setf sapic
augroup END

augroup filetype_c
    autocmd!
    autocmd Filetype c set shiftwidth=8 tabstop=8 softtabstop=8
    autocmd Filetype cpp set shiftwidth=8 tabstop=8 softtabstop=8
augroup END



"
" plugin settings
"
" latex
let g:tex_flavor = "latex"


" auto strip whitespace except for file with extention blacklisted
let blacklist = ['markdown', 'md']
autocmd BufWritePre * StripWhitespace


" lightline
let g:lightline = { 'colorscheme': 'Dracula' }


" nerdtree
" for toggling
nmap <C-n> :NERDTreeToggle<CR>
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

let NERDTreeIgnore=['\.vim$', '\~$', '\.git$', '.DS_Store']

" close nerdtree and vim on close file
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
