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
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'reedes/vim-pencil'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'justinmk/vim-sneak'
Plug 'joshdick/onedark.vim'

" modeline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep=' '
call plug#end()

" open another buffer without saving current buffer
set hidden

set cpo+=J

set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4


" keymaps
let mapleader='\<Space>'


" eye candies
if has ('termguicolors')
  set termguicolors
endif
let g:onedark_terminal_italics=1
colorscheme onedark


" filetype-specific indentation
augroup filetype_vim
  autocmd!
  autocmd Filetype vim set shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup filetype_c
  autocmd!
  autocmd Filetype c,c++ set shiftwidth=8 tabstop=8 softtabstop=8
augroup END


" writing mode
let g:pencil#wrapModeDefault='soft'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
