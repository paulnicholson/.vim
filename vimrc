" No Vi Compatibility
set nocompatible

set rubydll=~/.rbenv/versions/3.1.0/lib/libruby.3.1.dylib
let g:CommandTPreferredImplementation='ruby'

" Load bundles
call pathogen#runtime_append_all_bundles()

syntax enable

" Load plugins for filetypes
filetype plugin indent on

" For custom mappings
let mapleader = ","
let g:project_dir = "~/workspace/"

" Wrapping
set nowrap

" Highlight the line the cursor is on
set cursorline

" Show possible command line completions
set wildmenu

set number

" Basic tab behavior
set autoindent
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" Splitting Behaviors
set splitbelow
set splitright

" Persistent undo
if v:version >= 703
  set undodir=~/.vim/tmp
  set undofile
  set undolevels=1000 "maximum number of changes that can be undone
  set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif


if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
  colorscheme jellybeans
  set fuoptions=maxvert,maxhorz
endif


" Strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" recognize Capfile, Gemfile
autocmd BufRead,BufNewFile Capfile set filetype=ruby
autocmd BufRead,BufNewFile Gemfile set filetype=ruby

" Reveal current file in tree
map <leader>R :NERDTreeFind<CR>

" Open tree on current directory
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

map <leader>v ^:s/^\s*-/✓/<CR>

imap <C-L> <space>=><space>
imap <C-D> <DEL>
imap <D-Return> <ESC>o

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

map <D-r> :call RunRubyFile()<CR>

function! RunRubyFile()
  let old_make = &makeprg
  try
    let &l:makeprg = 'ruby '.expand("%")
    exe 'make'
    cwindow
  finally
    let &l:makeprg = old_make
  endtry
endfunction

function! Camelize(name)
  return substitute(a:name, '\v%(^(.)|_(.))', '\u\1\u\2', 'g')
endfunction

function! ModelName()
  return substitute(Filename('', 'model'), 's_controller', '', '')
endfunction

function! CamelModelName()
  return Camelize(ModelName())
endfunction


" ======================
"     Tab Label
" ======================

function! TabLabel()
  if exists("t:directory")
    return t:directory
  else
    return ""
  endif
endfunction

" set g:rails_projections = {
"	      \ "**/*.coffee": {"command": "coffeescript"},
"	      \ "**/*.feature": {"command": "feature"}}

" autocmd User Rails Rnavcommand coffeescript        app/javascripts            -glob=**/* -suffix=.js.coffee
" autocmd User Rails Rnavcommand feature             features                   -glob=**/* -suffix=.feature


" command-t
silent! nmap <unique> <silent> <Leader>f :CommandT<CR>
nnoremap <leader>F :CommandTFlush<CR>:CommandT<CR>
set wildignore+=public/assets/**,build/**,vendor/plugins/**,vendor/linked_gems/**,vendor/gems/**,vendor/rails/**,vendor/ruby/**,vendor/cache/**,Libraries/**,coverage/**
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=0

" Auto Tabularize
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
