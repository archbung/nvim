if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/bundle')


Plug 'junegunn/vim-plug'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'
Plug 'neomake/neomake'
"Plug 'w0rp/ale'
"let g:ale_linters = {
      "\ 'haskell': ['hlint','stack_build','stack_ghc'],
      "\ }

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'
let g:org_todo_keywords=['TODO', 'FEEDBACK', 'VERIFY', '|',
      \ 'DONE', 'DELEGATED']
Plug 'mattn/calendar-vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'

"Plug 'rust-lang/rust.vim'
"Plug 'cespare/vim-toml'
"Plug 'neovimhaskell/haskell-vim'
Plug 'sheerun/vim-polyglot'
let g:haskell_classic_highlighting=1
let g:polyglot_disabled=['latex']
Plug 'parsonsmatt/intero-neovim'
let g:intero_start_immediately=0
let g:intero_type_on_hover=1
let g:intero_window_size=15
"let g:intero_vertical_split=1
"Plug 'stephpy/vim-yaml'

Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
Plug 'ledger/vim-ledger'

Plug 'nanotech/jellybeans.vim'
let g:jellybeans_overrides = {
      \ 'background': { 'ctermbg': 'none', '256ctermbg': 'none', 'guibg': 'none' },
      \ }
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }


call plug#end()

call neomake#configure#automake('w')


" True colors ftw
set termguicolors
colorscheme jellybeans


" Saner split behaviour
set splitright
set splitbelow

set cpoptions+=J
set autowriteall
set hidden
set ignorecase
set smartcase
set formatoptions=q,r,n,1
set noshowmode
set scrolloff=5

set updatetime=1000
set shell=/usr/bin/bash


let g:mapleader="\<Space>"
let g:maplocalleader="\\"
nnoremap j gj
nnoremap k gk
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>bb :Buffers<CR>

" <C-[> is equivalent to <Esc> but easier to reach
tnoremap <C-[> <C-\><C-n>

" Allow saving of files when forget to sudo
cmap w!! w !sudo tee > /dev/null %

if executable('rg')
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Ggrep
        \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
  command! -bang Colors
        \ call fzf#vim#colors({'left': '15%', 'options:': '--reverse --margin 30%,0'}, <bang>0)
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
endif


augroup basic
  au!

  " Go to insert mode by default on terminal buffers
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif

  " Set textwidth for mutt buffers
  au BufRead /tmp/mutt-* setlocal textwidth=72

  " Remember last cursor position
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exec "normal! g`\"" |
        \ endif

  " Basic stuffs for vim configs
  au Filetype vim setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

augroup haskell
  au!
  au Filetype haskell setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
  au Filetype cabal setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  " Background process
  au Filetype haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au Filetype haskell nnoremap <silent> <leader>ik :InteroKill<CR>
  " Open intero in horizontal split
  au Filetype haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  " Open intero in vertical split
  au Filetype haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au Filetype haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  " Reloading
  au Filetype haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  " Load individual modules
  au Filetype haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au Filetype haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>
  " Type-related info
  au Filetype haskell map <silent> <leader>t <Plug>InteroGenericType
  au Filetype haskell map <silent> <leader>T <Plug>InteroType
  au Filetype haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>
  " Navigation
  au Filetype haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
  " Managing targets
  au Filetype haskell nnoremap <leader>ist :InteroSetTargets<SPACE>
augroup END

augroup yaml
  au!
  au Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
