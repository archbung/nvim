" vim:set ts=2 sts=2 sw=2 et:

"" Packages
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/bundle')


" Essentials
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_history_dir = '~/.local/share/fzf-history'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'psliwka/vim-smoothie'

" Git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Rg with preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" Lang support
Plug 'sheerun/vim-polyglot'
let g:haskell_classic_highlighting = 1
let g:polyglot_disabled=['latex', 'r\-lang']  " vim-polyglot uses latexbox instead of vimtex
Plug 'lervag/vimtex'
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 1
Plug 'jalvesaq/Nvim-R'


" Snippets and completion
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-b>"
let g:UltiSnipsJumpBackwardTrigger = "<C-z>"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi'
Plug 'racer-rust/vim-racer'


" Syntax checking
Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_haskell_stack_ghc_options = '-fno-code -v0 -Wall -Wcompat -Wincomplete-uni-patterns -Wredundant-constraints -Wincomplete-record-updates'

let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}

" Eye candies
Plug 'Rigellute/rigel'
Plug 'airblade/vim-gitgutter'

call plug#end()


" Options
set termguicolors
colorscheme rigel

set splitright splitbelow
set cpoptions+=J


" Keymaps
let g:mapleader="\<Space>"
let g:maplocalleader="\\"

nnoremap <leader>ff :Files<CR>
nnoremap <leader>bb :Buffers<CR>
tnoremap <C-[> <C-\><C-n>


augroup basic
  au!

  " Go to insert mode by default on terminal buffers
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif

  " Set textwidth for mutt buffers
  au BufRead /tmp/mutt-* setlocal textwidth=72
augroup END
