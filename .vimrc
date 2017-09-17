execute pathogen#infect()

syntax on

"Space indent
filetype plugin indent on
"   show existing tab with 4 spaces width
set tabstop=4
"   when indenting with '>', use 4 spaces width
set shiftwidth=4
"   On pressing tab, insert 4 spaces
set expandtab

"Disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Don't indent when pasting
set paste

"Show whitespaces
set listchars=tab:>·,trail:·,extends:>,precedes:<,space:·
set list

"Line Number
set number
highlight LineNr ctermfg=darkgrey
