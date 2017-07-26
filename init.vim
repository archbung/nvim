" Bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')

" lang support
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
Plug 'neomake/neomake'
Plug 'parsonsmatt/intero-neovim'
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille'

" org mode
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'

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
let g:lightline = { 'colorscheme': 'Dracula' }
Plug 'dracula/vim'
Plug 'mhinz/vim-startify'

call plug#end()


set cpo+=J
set hidden
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set scrolloff=6

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
endif

set splitbelow
set splitright

set termguicolors
colorscheme dracula


let mapleader = "\<Space>"
let maplocalleader = "\\"
nnoremap j gj
nnoremap k gk
nnoremap <leader>fs :w<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>fed :vsplit $MYVIMRC<CR>

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


augroup tamarin
  au BufNewFile,BufRead *.spthy setf spthy
  au BufNewFile,BufRead *.sapic setf sapic
augroup END

" filetype-specific indentation
augroup filetype_c
  autocmd!
  autocmd Filetype c set shiftwidth=8 tabstop=8 softtabstop=8
  autocmd Filetype cpp set shiftwidth=8 tabstop=8 softtabstop=8
augroup END
