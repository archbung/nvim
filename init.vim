if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
let g:haskell_classic_highlighting = 1
let g:polyglot_disabled=['latex']
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode=0
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

" True colors
set termguicolors
colorscheme jellybeans


" Better split behaviour
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
set shell=/usr/bin/zsh


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
augroup END

augroup yaml
  au!
  au Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END
