" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
"set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Indentation config:
if has("autocmd")
  " indent diffrent files according to their indent file
  filetype plugin indent on
  " set line length to 80 chars for text files
  autocmd FileType text setlocal textwidth=80
else
  " have auto indent any way
  set autoindent
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


packloadall

set nu
set shiftwidth=4
set nocindent
set expandtab
set colorcolumn=80
set spell
set mouse=a
set undofile

set formatoptions=tcrqj
set textwidth=79
color afterglow


highlight NonText ctermbg=None
highlight EndOfBuffer ctermbg=None
highlight Normal ctermbg=None

highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=9
highlight SpellBad gui=undercurl guifg=#ff0000

syntax on

"slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_bracketed_paste = 1
let g:slime_cell_delimiter = "^```.*"

nmap <c-c><c-c> <Plug>SlimeCellsSend

