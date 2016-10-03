" bootstrap vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore-dir={autoload,bundle,snapshots,indices,chromium-backup,chromium-back-ovfs}  -g ""'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'

Plug 'reedes/vim-pencil'
let g:pencil#wrapModeDefault='soft'

Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'

Plug 'neomake/neomake'
autocmd! BufWritePost * Neomake

" colorscheme
Plug 'mhartington/oceanic-next'
let g:oceanic_next_terminal_italic=1
let g:oceanic_next_terminal_bold=1

" modeline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='oceanicnext'
let g:airline_left_sep=' '
let g:airline_right_sep=' '
call plug#end()

" open another buffer without saving current buffer
set hidden

set cpo+=J

set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

if has ('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme OceanicNext


"
" keymaps
"
let mapleader="\<Space>"
nnoremap j gj
nnoremap k gk

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" init file
nnoremap <leader>fed :e $MYVIMRC<CR>
nnoremap <leader>sb :so %<CR>

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

" searching
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files ~<CR>
nnoremap <leader>fr :History<CR>

" buffers
nnoremap <leader>bl :Buffers<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" toggle
nnoremap <leader>tg :Goyo<CR>

" error checking
nnoremap <leader>el :lopen<CR>
nnoremap <leader>en :lnext<CR>
nnoremap <leader>ep :lprevious<CR>

" terminal
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l


" filetype-specific indentation
augroup filetype_c
  autocmd!
  autocmd Filetype c,c++ set shiftwidth=8 tabstop=8 softtabstop=8
augroup END


" writing mode
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
