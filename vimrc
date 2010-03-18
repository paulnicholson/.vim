" No Vi Compatibility
set nocompatible

" Load bundles
call pathogen#runtime_append_all_bundles()

syntax enable

" Load plugins for filetypes
filetype plugin indent on

" For custom mappings
let mapleader = ","

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

if has("gui_running")
  set guioptions+=TlRLrb
  set guioptions-=TlRLrb
endif

colorscheme textmate

" Strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" recognize Capfile, Gemfile
autocmd BufRead,BufNewFile Capfile set filetype=ruby
autocmd BufRead,BufNewFile Gemfile set filetype=ruby

" Reveal current file in tree
map <leader>R :NERDTreeFind<CR>

" Open tree on current directory
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

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
