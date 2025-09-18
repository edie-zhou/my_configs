set nocompatible " required

"=================================================================
" Some basic stuff to always include
"=================================================================

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			              " always set autoindenting on
set viminfo='20,\"50	    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50		        " keep 50 lines of command line history

" some base autocommands that I think everyone should use
augroup ubuntu
  autocmd!

  " when editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

  " after writing to the .vimrc file, auto-source it
  autocmd BufWritePost .vimrc source %

augroup END

" set the file type for certain file extensions to be the correct ones for proper syntax highlighting
augroup my_file_type_conversions
  autocmd!
  autocmd BufNewFile,BufRead *.launch set filetype=xml
  autocmd BufNewFile,BufRead *.msg set ft=config
augroup END

" enable syntax checking
syntax enable

" now you can close the file, get back in, and still maintain the original undo tree
set undolevels=5000
set undodir=~/.vim/undo
set undofile

"=================================================================
" 'set' vimrc things (basics)
"=================================================================

" colorscheme
set background=dark

" show (partial) command in status line (e.g. number of lines selected in visual mode, etc.)
set showcmd

" indicate which vim mode you're currently in (INSERT, VISUAL, etc)
set showmode

" show the absolute file path in the title of the window itself (see upper left of screen)
set title

" disable swap file generation
"set noswapfile

" Automatically save before commands like :make
set autowrite

" Hide buffers when they are abandoned
set hidden

" use spaces instead of tabs
set expandtab

" prevent ubuntu from outputting garbage characters
set t_RV=

"turn on ruler
set ruler


"=================================================================
" 'set' vimrc things (preferences)
"=================================================================

" enable search highlighting by default
set hlsearch

"turn on hybrid line numbers
set number relativenumber

"toggle normal line numbers for inserting, else relative line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
" display all matching files when you tab-complete
set wildmenu
set wildignorecase

" Searching related options
set ignorecase          " Case insensitive matching
set smartcase           " Smart case matching
set incsearch           " Start searching for the pattern as it's typed out
set hlsearch            " Enable search highlighting by default
set shortmess=filnxtToO " Same as defaults. Removed 'S' flag to enable search index when using 'n' and 'N' (e.g. [3/7])

" always show the tabline (tab header bar)
set showtabline=2
set tabpagemax=100

" Set these variables to these values to allow all tab-related options to follow the 'tabstop' variable
set shiftwidth=0
set softtabstop=-1

" Set the tab length
set tabstop=4
" set tabstop=2 " NOTE: For ROS, the convention is to use tabs of length 2

" set autoindent and smart tabbing
set autoindent
set smarttab
" set smartindent " NOTE: Don't enable this because it auto shifts '#' to the beginning of the line and can't tab it using '>' or '<'
" set cindent " NOTE: Don't enable this for the same reasons as ^

" Each line can have this many characters
"set textwidth=140 " For work laptop
set textwidth=120 " For personal laptop

" lets the tags file to be in a separate directory from the source code
" basically just goes up one directory at a time until it finds a file called '.tags'
set tags=.tags;/

" searches down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" change vimdiff options so it uses filler lines and produces diff in a vertical split
set diffopt=filler,vertical

" vimdiff ignore whitespace
set diffopt+=iwhite
set diffexpr=diff#IgnoreWhitespace()

" make the clipboard the default register
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
else
  set clipboard=unnamed
endif

"=================================================================
" 'highlight' things
"=================================================================

" set matching parenthesis/brace/bracket to be underlined instead of highlight
highlight MatchParen cterm=underline ctermbg=none ctermfg=none

" make the vim tab bar look prettier
highlight   TabLine       term=None   cterm=Underline   ctermfg=Blue    ctermbg=Black    gui=None " part of tabline that isn't selected
highlight   TabLineSel    term=None   cterm=Reverse                                      gui=None " part of tabline that is highlighted
highlight   TabLineFill   term=None   cterm=None        ctermfg=Black   ctermbg=Black    gui=None " the rest of the tabline


