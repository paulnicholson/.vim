" Make Save leave edit mode
macmenu File.Save  key=<nop>
map <D-s> :w<CR>
imap <D-s> <ESC>:w<CR>

set guitablabel=%{TabLabel()}

set macligatures
set guifont=Fira\ Code:h12
