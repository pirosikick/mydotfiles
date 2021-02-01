if &compatible
  set nocompatible
endif

if has('win32') || has('win64')
  " For Windows.
  language message en
  let $MYVIMDIR = expand('~/vimfiles')
  " Exchange path separator.
  set shellslash
else
  " For Linux.
  language mes C
  let $MYVIMDIR = expand('~/.vim')
endif

" dein.vim {{{
" http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/rc/lazy_dein.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif
endif


filetype plugin indent on
" }}}

" Basic Options {{{
" indent
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
" search
set nohlsearch
set smartcase
" listchars
set list
set listchars=tab:^_,trail:-,extends:>,precedes:<,eol:$
" shift
set shiftround
set shiftwidth=2
" completion
set complete=.,w,b,u,t,i,d,k,kspell
set completeopt=menu,preview
set wildmenu
set wildmode=list:longest
set pumheight=20
" swap
set swapfile
set directory-=.
" scroll
set scrolloff=2
" colorcolumn
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=9
endif
" backup
set backup
let &backupdir = $MYVIMDIR . '/backup'
if !isdirectory(&backupdir)
  call mkdir(&backupdir, 'p')
endif
" reload automatically if file has changed
set autoread
" statusline
set laststatus=2
set statusline=%<%f\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v\ %l/%L
" syntax
syntax on
set t_Co=256
set background=dark
let g:solarized_termcolors=256
try
  colorscheme solarized
catch
endtry
" number
set number
set numberwidth=1
set hidden
set shortmess+=I
set laststatus=2
set cmdheight=1
set showcmd
set backspace=indent,start
" fold
set foldenable
set foldmethod=marker
set foldlevelstart=0
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
" encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,ucs2le,ucs-2,cp932,euc-jp
" fileformats
set fileformats=unix,dos,mac
" enable modeline
set modeline
" undo
set undodir=~/tmp/vim
" Using the mouse on a terminal.
" http://yskwkzhr.blogspot.jp/2013/02/use-mouse-on-terminal-vim.html
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif
if has('clipboard')
  set clipboard=unnamed
endif
" }}}

function! s:use_tab_indent()
  setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
endfunction

augroup pirosikick_vimrc
  au!
  au filetype make call s:use_tab_indent()
  au filetype go call s:use_tab_indent()
  au BufNewFile,BufRead *.json setlocal filetype=json
  au BufNewFile,BufRead *.js setlocal filetype=javascript.jsx
augroup END

" Plugin Settings {{{
" neocomplete
let g:acp_enableAtStartup = 1
let g:neocomplete#data_directory = "~/.vim/tmp/swap"
let g:neocomplete#enable_at_startup = 1
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" quickrun
let g:quickrun_config = {
      \ '*': {'hook/time/enable': '1'},
      \'javascript': { "exec": "node %s" },
      \'javascript.jsx': { "exec": "node %s" }
      \}



" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" neosnippet
let g:neosnippet#snippets_directory=[
      \'~/.cache/dein/repos/github.com/pirosikick/vim-snippets/snippets',
      \'~/.cache/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets',
      \]
" vim-markdown
let g:vim_markdown_fenced_languages = ['js=javascript', 'jsx=javascript.jsx']
" vim-flow
" Disable typecheck, because ale do
let g:flow#enable=0
" ale
set statusline+=%{ALEGetStatusLine()}
let g:ale_statusline_format = ['E%d', 'W%d', '']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
"}}}

" Map {{{
" g
nmap j gj
nmap k gk
vmap j gj
vmap k gk
" <Leader>
let mapleader = ","
" :nohlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>
" window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nmap { <C-W><
nmap } <C-W>>
" ag
nnoremap <space>/ :Ag 
" fugitive
noremap [fugtive] <Nop>
map <Leader>g [fugtive]
nnoremap <silent>[fugtive]s :Gstatus<CR>
nnoremap <silent>[fugtive]a :Gwrite 
nnoremap <silent>[fugtive]c :Gcommit<CR>
nnoremap <silent>[fugtive]d :Gdiff<CR>
nnoremap <silent>[fugtive]r :Gread<CR>
" CtrlP
nnoremap <Leader>f :<C-u>CtrlP<CR>
nnoremap <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <Leader>m :<C-u>CtrlPMixed<CR>
nnoremap <Leader>l :<C-u>CtrlPLine<CR>
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" }}}

