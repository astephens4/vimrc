"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic
"       http://amix.dk - amix@amix.dk
"
" Version:
"       5.0 - 29/05/12 15:43:36
"
" Blog_post:
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version:
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

if has("win32")
    let g:clang_library_path='C:\Program Files (x86)\LLVM\bin\libclang.dll'

    " Plantuml integration
    let g:plantuml_executable_script='java -jar '.$APPDATA.'\plantuml.jar'
endif

" set the runtime path to include Vundle and initialize
set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim
call vundle#begin('$USERPROFILE/vimfiles/bundle/')

" ClearCase plugin
Plugin 'ccase.vim'

" Plantuml integration
Plugin 'aklt/plantuml-syntax'

" Best window swapper
Plugin 'wesQ3/vim-windowswap'

" Clang based code completion for C++
Plugin 'myint/clang-complete'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Configuration for clang_complete
let g:clang_library_path='C:\Program Files\LLVM\bin'
let g:clang_auto_select=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
let g:clang_user_options='-I..\inc\'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on
set nocp

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show line numbers
set number

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert
set background=dark

if has("gui_running")
    " Let visual selection use the clipboard automatically
    set guioptions+=a

    " Remove the toolbar, because f**k that.
    set guioptions-=T

    " Use GUI element tablines
    set guioptions+=e

    " Show a horizontal scroll line
    set guioptions+=b
    set guioptions+=h

    " Support 256 colors
    set t_Co=256

    " Show the modified marker and file name in the GUI tab
    set guitablabel=%m\ %t

    " Set the font to be something awesome
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ 9
    elseif has("gui_win32")
        set guifont=DejaVu\ Sans\ Mono:h9
    endif

    " When resizing the GUI, make all of the split buffers equal in size
    au VimResized * wincmd =
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Clear search highlights by pressing escape
nnoremap <esc>  :noh<return><esc>

" Map jk to esc in order to save my knuckles
inoremap jk <esc>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=%F%m%r%h\ %w\ \ \ Line:\ %l\ \ Col:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Before jumping into my epic mappings, lets define a leader
:let mapleader = " "
:let maplocalleader = "\\"

" Start adding my epic mappings here

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nnoremap <D-j> <M-j>
  nnoremap <D-k> <M-k>
  vnoremap <D-j> <M-j>
  vnoremap <D-k> <M-k>
endif

" Save my knuckles by using jk to exit insert mode
inoremap jk <esc>

" Make switching  between multiple buffers better
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Map c-space to include complete
map <c-space> <c-x><c-i>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Make switching between multiple tabs better
nnoremap <leader>th :tabp<cr>
nnoremap <leader>tl :tabn<cr>

" I like the leader w mapping to write
nnoremap <leader>w :w!<return>

" Make backspace reasonable
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Make some cool mappings for home, end, pgup and pgdown
noremap <leader>h ^
nnoremap <leader>l $
vnoremap <leader>l $h
noremap <leader>j <PageDown>
noremap <leader>k <PageUp>

" Make a quick edit to my vimrc and reload
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

" Operator to select word under cursor
onoremap wuc :<c-u>normal! bve<cr>

" Surround words with different characters
nnoremap    <leader>(   mnbi(<esc>ea)<esc>`nl
nnoremap    <leader>{   mnbi{<esc>ea}<esc>`nl
nnoremap    <leader>[   mnbi[<esc>ea]<esc>`nl
nnoremap    <leader><   mnbi<<esc>ea><esc>`nl
nnoremap    <leader>"   mnbi"<esc>ea"<esc>`nl
nnoremap    <leader>'   mnbi'<esc>ea'<esc>`nl
nnoremap    <leader>ds  mnbhxex`nh

vnoremap    <leader>(   <esc>`<i(<esc>`>la)<esc>
vnoremap    <leader>{   <esc>`<i{<esc>`>la}<esc>
vnoremap    <leader>[   <esc>`<i[<esc>`>la]<esc>
vnoremap    <leader>'   <esc>`<i'<esc>`>la'<esc>
vnoremap    <leader>"   <esc>`<i"<esc>`>la"<esc>
vnoremap    <leader>ds  <esc>`<mn`>x`nx

" Extend the line with the last character out to 120 columns
nnoremap    <leader>ec <end>vy120p<esc>d120\|^<cr>

" Go to the last character in the file
nnoremap G   G<End>

" Map double click to highlight all occurrences of the word under cursor
nnoremap <2-LeftMouse>  *#
inoremap <2-LeftMouse>  <c-o>*<c-o>#

" Insert and append a single character in normal mode
nnoremap <leader>i  vyphr
nnoremap <leader>a  vypr

" Mapping to close the preview window while in insert mode
inoremap <c-q> <esc>:pc<cr>a
nnoremap <leader>q :pc<cr>

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWritePre * :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the dictionary
if has("win32")
    set dict+=$APPDATA/dict/final/english-words.10
    set dict+=$APPDATA/dict/final/english-words.20
    set dict+=$APPDATA/dict/final/english-words.35
    set dict+=$APPDATA/dict/final/english-words.40
    set dict+=$APPDATA/dict/final/english-words.50
    set dict+=$APPDATA/dict/final/english-words.60
    set dict+=$APPDATA/dict/final/american-words.10
    set dict+=$APPDATA/dict/final/american-words.20
    set dict+=$APPDATA/dict/final/american-words.35
    set dict+=$APPDATA/dict/final/american-words.40
    set dict+=$APPDATA/dict/final/american-words.50
    set dict+=$APPDATA/dict/final/american-words.55
    set dict+=$APPDATA/dict/final/american-words.60

    " Add the dirty words... hehehehe
    set dict+=$APPDATA/dict/misc/profane.1
    set dict+=$APPDATA/dict/misc/profane.3
endif

" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
nnoremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Turn off the god-damned bells when I press ESC in regular mode
set noeb vb t_vb=
au GUIEnter * set vb t_vb=|simalt ~x

set tags=tags;

" Autocmds for C and C++
augroup CAndCpp
    autocmd!
    autocmd FileType cpp nnoremap <buffer> <localleader>c 0i//<esc>
    autocmd FileType cpp nnoremap <buffer> <localleader>uc :s!^\(\s*\)//!\1!ge<cr>:nohlsearch<cr>
    autocmd FileType cpp vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!//!ge"<cr>:nohlsearch<cr>
    autocmd FileType cpp vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^//!!ge"<cr>:nohlsearch<cr>
    autocmd FileType cpp :iabbrev <buffer> iff if ()<cr>{<cr>}<up><up><end><left>
    autocmd FileType cpp :iabbrev <buffer> fori for (auto i = 0; i <; ++i)<cr>{<cr>}<up><up><end><left><left><left><left><left><left>
    autocmd FileType cpp :let g:load_doxygen_syntax=1
augroup END

" Autocmds for Python
augroup Python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c 0i#<esc>
    autocmd FileType python nnoremap <buffer> <localleader>uc :s!^\(\s*\)#!\1!ge<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!#!ge"<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^#!!ge"<cr>:nohlsearch<cr>
    autocmd FileType python :iabbrev <buffer> iff if:<left>
augroup END
