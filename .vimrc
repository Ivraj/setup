" for Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Install yaml highlighting
Plugin 'chase/vim-ansible-yaml'

" Solarized
Plugin 'sickill/vim-monokai'
Plugin 'altercation/vim-colors-solarized'

" Syntax highlighting
Plugin 'scrooloose/syntastic'

" Commenter plugin
Plugin 'scrooloose/nerdcommenter'

call vundle#end()

" Appearance
syntax enable

" Searching
set incsearch
set hlsearch

" for Commenter
filetype plugin on

"can be changed to desert for readability
colorscheme monokai

" Spacing
set tabstop=4 "4 spaces for tab
set softtabstop=4
set shiftwidth=4
set expandtab " tab with spaces
set lazyredraw " redraw only when we need to.
set showmatch "Highlight the closing parend
set number " Show line number.
set relativenumber " Show other line numbers relative to cursor.
set autoindent
set tw=79

" Allow saving of files as sudo without logging in as sudo
cmap w!! w !sudo tee > /dev/null %

" Text
set pastetoggle=<F2> "Hit f2 to enter paste mode

" Key remapping
let mapleader="\<Space>" "Use space bar as the leader key

" Move to the beginning or end of the line
nnoremap B ^
nnoremap E $
nnoremap J <PageDown> 
nnoremap K <PageUp>
inoremap jk <Esc>
vnoremap jk <Esc>
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
nmap ; :

"Add in most recent command
nnoremap <silent> <leader>m :CtrlPMRU<CR>

" Decrease the timeout
set timeoutlen=200

"Replace common functions for writing
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>s :vs<CR>
nnoremap <Leader>v :e ~/.vimrc<CR>

" Updates files even while it's open
set autoread

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
