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
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 1
let g:fzf_history_dir = '~/.local/share/fzf-history'
let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ }
  call nvim_open_win(buf, v:true, opts)
endfunction
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/org/wiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]

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
let g:polyglot_disabled=['r\-lang']
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_quickfix_mode = 1


" Snippets and completion
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-b>"
let g:UltiSnipsJumpBackwardTrigger = "<C-z>"
Plug 'dense-analysis/ale'


" Eye candies
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'psliwka/vim-smoothie'
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [[ 'mode', 'paste', ],
      \            [ 'gitbranch', 'readonly', 'filename', ]],
      \   'right':
      \     [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', ],
      \      [ 'lineinfo'], [ 'percent' ], [ 'filetype']]
      \   },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filename' : 'LightlineFilename',
      \   },
      \ 'component_expand': {
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \   },
      \ 'component_type': {
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \   },
      \ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

set noshowmode

call plug#end()


" Options
set termguicolors
colorscheme onedark

set splitright splitbelow
set cpoptions+=J


" Keymaps
let g:mapleader="\<Space>"
let g:maplocalleader="\\"

nnoremap <leader>ff :Files<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap j gj
nnoremap k gk
tnoremap <C-[> <C-\><C-n>

augroup basic
  au!

  " Go to insert mode by default on terminal buffers
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif

  " Set textwidth for mutt buffers
  au BufRead /tmp/mutt-* setlocal textwidth=72
augroup END
