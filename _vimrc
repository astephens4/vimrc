set nocompatible              " be iMproved, required
filetype off                  " required

" Load the clearcase plugin
let UsingClearCase = 1

" Control bitness
let NumBits = 64

if has("win32")
    " set the runtime path to include Vundle and initialize
    set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim
    call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Plantuml integration
Plugin 'aklt/plantuml-syntax'

" Best window swapper
Plugin 'wesQ3/vim-windowswap'

" Clang based code completion for C++
Plugin 'Rip-Rip/clang_complete'
"Plugin 'vim-scripts/OmniCppComplete'

" Python autocomplete plugin
Plugin 'davidhalter/jedi-vim'

" Tab completion, for better auto complete
Plugin 'ervandew/supertab'

" Get a better light color theme
Plugin 'NLKNguyen/papercolor-theme'

" The mandatory tpope plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'

" Bump font size up and down with <leader><leader>+/-
Plugin 'drmikehenry/vim-fontsize'

" Clearcase plugin, but only on the work computer
if (UsingClearCase != 0)
    Plugin 'ccase.vim'
    " Checkout the file, unreserved
    command! -nargs=+ -complete=file MCtcou !cleartool co -unreserved <args>
    " Checkout the file, reserved
    command! -nargs=+ -complete=file MCtcor !cleartool co -reserved <args>
    " Undo the file checkout
    command! -nargs=+ -complete=file MCtuco !cleartool unco <args>
    " Checkin the file
    command! -nargs=+ -complete=file MCtci !cleartool ci <args>
    " Open the version tree for the file
    command! -nargs=+ -complete=file MCtvt !cleartool lsvtree -graphical <args>
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if has("win32")
    let LLVM_VERSION = '60'
    " Specify the clang installation
    if NumBits == 32
        let g:clang_library_path='C:\Program Files (x86)\LLVM_'.LLVM_VERSION.'\bin\libclang.dll'
    elseif NumBits == 64
        let g:clang_library_path='C:\LLVM_'.LLVM_VERSION.'\bin\libclang.dll'
        set pythonthreedll=C:\Program\ Files\Python36\python36.dll
    endif

    " Plantuml integration
    let g:plantuml_executable_script='java -jar '.$APPDATA.'\plantuml.jar'
else
    " Specify the clang installation
    if NumBits == 32
        let g:clang_library_path='/usr/lib/llvm-3.9/lib'
    elseif NumBits == 64
        let g:clang_library_path='/usr/lib64'
    endif
endif

" Configuration for clang_complete
let g:clang_use_library=1
let g:clang_auto_select=1
let g:clang_complete_macros=1
let g:clang_complete_patterns=1
let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=1
let g:clang_user_options='-std=c++14 -m32 -Wall -Wextra -Werror -fms-extensions'
let g:clang_auto_user_options=".clang_complete"

" Uncomment in case of emergency
" let g:clang_debug = 1

"set tags=./tags;/
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 1
"set completeopt=menuone,menu,longest,preview

let g:SuperTabDefaultCompletionType = '<c-x><c-u>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

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

" When searching try to be smart about cases. Note - smartcase only works when ignorecase is also set
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show line numbers
set number
set relativenumber

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use DOS as the standard file type
if has("win32")
    set ffs=dos,unix,mac
else
    set ffs=unix,dos,mac
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
endif

augroup OnFileOpen
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

if has("gui_running")
    colorscheme PaperColor

    " Let visual selection use the clipboard automatically
    set guioptions+=a

    " Remove the toolbar
    set guioptions-=T

    " Use GUI element tablines
    set guioptions+=e

    " Show a horizontal scroll line
    set guioptions+=b
    set guioptions+=h
    set guioptions-=L

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

    " Disable the bells, again
    autocmd GUIEnter * set vb t_vb=

    " When resizing the GUI, make all of the split buffers equal in size
    au VimResized * wincmd =
else
    colorscheme PaperColor
    set term=xterm
    set t_Co=256
    set t_Sb=m
    set t_Sf=m
    if has("win32")
        let &t_AB="\e[48;5;%dm"
        let &t_AF="\e[38;5;%dm"
        inoremap <Char-0x07F> <BS>
        nnoremap <Char-0x07F> <BS>
    end
endif
set background=dark

" Draw a colorful line at column 120
set colorcolumn=120
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
highlight Pmenu ctermbg=Cyan ctermfg=DarkGrey guibg=Cyan guifg=DarkGrey
highlight PmenuSel ctermbg=LightGrey ctermfg=Black guibg=LightGrey guifg=Black
highlight PmenuSbar ctermbg=LightGrey guibg=LightGrey
highlight PmenuThumb ctermbg=darkgrey guibg=darkgrey

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set dir=$APPDATA
set swapfile

set backupdir=$APPDATA
set nobackup
set wb

" Add a command which closes the current file in the buffer and opens a new one
command! -nargs=+ -complete=file We w | bd | e <args>

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

" Linebreak on 120 characters
set lbr
set tw=120

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
let mapleader = " "
let maplocalleader = "\\"

" Use jk to exit insert mode
inoremap jk <esc>

" Learn me to stop using visual mode and start doing things the vim way
nnoremap v :echom("Use text obects instead")<cr>

" Make some cool mappings for home, end, pgup and pgdown
noremap <leader>h ^
nnoremap <leader>l $
vnoremap <leader>l $h
noremap <leader>j <PageDown>
noremap <leader>k <PageUp>

" Yank and paste things from the system clipboard
if has("win32") || has("gui_running")
    nnoremap <leader>y "*y
    vnoremap <leader>y "*y
    nnoremap <leader>p "*p
    vnoremap <leader>p "*p
else
    nnoremap <leader>y "+y
    vnoremap <leader>y "+y
    nnoremap <leader>p "+p
    vnoremap <leader>p "+p
endif

if (UsingClearCase != 0)
    " Add some handy shortcuts, such as opening the version tree and diffing with predecessor
    nnoremap <leader>v :Ctxlsv<cr>
    nnoremap <leader>d :Ctpdif<cr>:set ft=cpp<cr><c-w>lgg
    nnoremap <leader>cd <c-w>h:q!<cr>:set nodiff<cr>
endif

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
set winaltkeys=no
nnoremap <M-h> xhP
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
nnoremap <M-l> xp

"vnoremap <M-h> xhP
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
"vnoremap <M-l> xp

if has("mac") || has("macunix")
  nnoremap <D-j> <M-j>
  nnoremap <D-k> <M-k>
  vnoremap <D-j> <M-j>
  vnoremap <D-k> <M-k>
endif

" Make switching  between multiple buffers better
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-h> <esc><c-w>h
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-l> <esc><c-w>l

" Make resizing windows easier
nnoremap <c-down> <c-w>-
nnoremap <c-up> <c-w>+
nnoremap <c-right> <c-w>>
nnoremap <c-left> <c-w><

" Map c-space to user defined complete
inoremap <c-space> <c-x><c-u>

" Map shift-tab to de-tab
inoremap <S-tab> <c-d>
vnoremap <tab> >gv
vnoremap <S-tab> <gv
nnoremap <tab> >>
nnoremap <S-tab> <<
vnoremap <cr> <esc>

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>\

" Close current buffer, switch tabs, and open buffer as vertical split
func! MoveToNextTab()
    let bufno = bufnr('%')
    write
    close!
    tabnext
    execute "vert sb ".bufno
endfunc

" Open file under cursor in the next tab as a vertical split
nnoremap <leader>ot <c-w>gf
nnoremap <leader>ov :vert wincmd f<cr>:call MoveToNextTab()<cr>
cnoreabbrev Vfind vert sf

" I like the leader w mapping to write
nnoremap <leader>w :w!<return>

" Make a quick edit to my vimrc and reload
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <leader>tv :tabedit $MYVIMRC<cr>

" Surround the visual selection with stuff
vnoremap    <leader>(   <esc>`<i(<esc>`>la)<esc>
vnoremap    <leader>{   <esc>`<i{<esc>`>la}<esc>
vnoremap    <leader>[   <esc>`<i[<esc>`>la]<esc>
vnoremap    <leader><   <esc>`<i<<esc>`>la><esc>
vnoremap    <leader>'   <esc>`<i'<esc>`>la'<esc>
vnoremap    <leader>"   <esc>`<i"<esc>`>la"<esc>
vnoremap    <leader>ds  <esc>`<mn`>x`nx

" Auto complete []{}() pairs
inoremap { {}<left>
inoremap {<cr> {<cr>}<up><end>
inoremap {{ {
inoremap {} {}
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<right>" : "}"

inoremap ( ()<left>
inoremap (( (
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<right>" : ")"

inoremap [ []<left>
inoremap [[ [
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<right>" : "]"

" Extend the line with the last character out to 80 columns
nnoremap    <leader>ec <end>vy120p<esc>d120\|^<cr>
nnoremap    <silent> <Plug>EscapeNewlineMapping <end>120A <esc>d120\|i\<esc>j:silent! call repeat#set("\<Plug>EscapeNewlineMapping", v:count)<CR>
nmap <leader>el <Plug>EscapeNewlineMapping

" Leave a mark when gg or G. Make G go to the end of the file
nnoremap gg mmgg
nnoremap G mmG$

" Make Y yank until the end of the line, similar to C, D, and S
nnoremap Y y$

" Map double click to highlight all occurrences of the word under cursor
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>
inoremap <2-LeftMouse>  <esc>mm:let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>`mi

" Insert and append a single character in normal mode
nnoremap <leader>i  vyphr
nnoremap <leader>a  vypr

" Mapping to close the preview and quickfix windows
inoremap <c-q> <esc>:pc<cr>:ccl<cr>a
nnoremap <leader>q :pc<cr>:ccl<cr>

" Toggle relativenumber
nnoremap <leader>n set relativenumber!

" Open file under cursor in a vertical split - replace the default mapping
nnoremap <c-w>f :vert wincmd f<cr>

" Insert the correctly formatted date in insert mode
inoremap <F3> <C-R>=strftime("%d-%b-%Y")<CR>
inoremap <F2> <C-R>=$USERNAME<CR><esc>vbuea
imap <F4> <c-o>o/ - <F2> <tab><F3><space>
nmap <F4> o/ - <F2> <tab><F3><space>

" Refresh a diff window
nnoremap <F5> :set nodiff<cr>:set diff<cr>
inoremap <F5> <esc>:set nodiff<cr>:set diff<cr>i

" Substitute word under cursor
nnoremap <leader>s mmyiw:%s/<c-r>"/
nnoremap <leader>S mmyiW:%s/<c-r>"/

" Replace word/WORD under cursor
nnoremap <leader>r "gyiw"0Plde
nnoremap <leader>R "gyiW"0PldE

" Insert a random integer
inoremap <F5> <esc>:call RandInt()<cr>a<c-r>a

nnoremap <leader>gg mmgg

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! FixWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  %s/\t/    /ge
  exe "normal `z"
endfunc
autocmd BufWritePre * :call FixWhitespace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the dictionary
if has("win32")
    " Use the dictionary downloaded from SCOWL: http://wordlist.aspell.net/
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
    set dict+=$APPDATA/dict/misc/profane.1
    set dict+=$APPDATA/dict/misc/profane.3
else
    set dict+=/usr/share/dict/words
endif

set spell

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Specific Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! ContainsMagicCppSequence()
    let pos = getpos(".")
    call cursor([1, 1])
    let isFound = search('-*-c++-*-', 'nw', 3)
    call cursor(pos[1:])
    return isFound
endfunc

" Autocmds for C and C++
augroup CAndCpp
    autocmd!
    " If the magic pattern is on one of the first three lines, set the file type to C++
    autocmd BufReadPost * if ContainsMagicCppSequence() | setlocal ft=cpp.doxygen | endif
    " Use doxygen syntax highlighting on top of C++ syntax highlighting
    autocmd FileType cpp setlocal syntax=cpp.doxygen
    " Do not indent goto labels
    autocmd FileType cpp setlocal cinoptions+=Ls
    " Do not indent inside of a namespace
    autocmd FileType cpp setlocal cinoptions+=N-s
    " Do not indent cases inside of a switch
    autocmd FileType cpp setlocal cinoptions+=:0
    " Align the insides of a case label with the case label
    autocmd FileType cpp setlocal cinoptions+=l1
    " Make the class scope declarations at the same indentation level as the class
    autocmd FileType cpp setlocal cinoptions+=g0
    " Comment a line with \c
    autocmd FileType cpp nnoremap <buffer> <localleader>c 0i//<esc>
    " Uncomment a line with \uc
    autocmd FileType cpp nnoremap <buffer> <localleader>uc :s!^\(\s*\)//!\1!ge<cr>:nohlsearch<cr>
    " Comment the lines in a visual selection with \c
    autocmd FileType cpp vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!//!ge"<cr>:nohlsearch<cr>
    " UnComment the lines in a visual selection with \uc
    autocmd FileType cpp vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^//!!ge"<cr>:nohlsearch<cr>
    autocmd FileType cpp inoreabbrev <buffer> rc< reinterpret_cast<
    autocmd FileType cpp inoreabbrev <buffer> sc< static_cast<
    autocmd FileType cpp inoreabbrev <buffer> cc< const_cast<
    " Insert an if statement with curly braces when typing iff
    autocmd FileType cpp inoreabbrev <buffer> iff if ()<cr>{<cr>}<up><up><end><left>
    " Insert a basic counter based for loop with curly braces by typing fori
    autocmd FileType cpp inoreabbrev <buffer> fori for (std::uint8_t i = 0U; i <; ++i)<cr>{<cr>}<up><up><end><left><left><left><left><left><left>
    " Insert a case of a switch statement
    autocmd FileType cpp inoreabbrev <buffer> casee case:<cr><cr>break;<up><up><end><left>
    " Insert a new class
    autocmd FileType cpp inoreabbrev <buffer> classs class<cr>{<cr><cr>};<up><up><up><end>
    autocmd FileType cpp inoreabbrev <buffer> structt struct<cr>{<cr><cr>};<up><up><up><end>
    autocmd FileType cpp inoreabbrev <buffer> unionn union<cr>{<cr><cr>};<up><up><up><end>
    " Open the file under cursor in a vertical split
    autocmd FileType cpp nnoremap <buffer> <localleader>v :vert wincmd f<cr>
    " Open the file under cursor in a new tab
    autocmd FileType cpp nnoremap <buffer> <localleader>o <c-w>gf
    " Open the h/hpp/c/cpp variant of this file which can be found on the path in a vertical split
    autocmd FileType cpp nnoremap <buffer> <localleader>s :call OpenSrcHeaderInVert(expand("%"))<cr>
    " Run the clang_complete compile command and open the quickfix window
    autocmd FileType cpp nnoremap <buffer> <localleader>m :call g:ClangUpdateQuickFix()<cr>
    " Create a new file using the header template
    autocmd FileType cpp nnoremap <buffer> <localleader>nh :exec '0r '.$APPDATA.'\\CppTemplates\\Header.hpp'<cr>
    " Insert the source code template
    autocmd FileType cpp nnoremap <buffer> <localleader>ns :exec '0r '.$APPDATA.'\\CppTemplates\\Source.cpp'<cr>
    " Count comment header/delimiter thingy lines
    autocmd FileType cpp nnoremap <buffer> <localleader>dc :%s/^\s*\/\/[\/\*]\{20,117}$//gn<cr>
    " Compile and run the current file
    autocmd FileType cpp nnoremap <buffer> <F7> :!g++ -std=c++11 -Wall -Wextra -Werror -pedantic % && .\a.exe
    " Format the current file
    autocmd FileType c,cpp setlocal equalprg=clang-format\ -style=file
    autocmd FileType c,cpp nnoremap <localleader>f mmgg=G`m
    " Delete doxygen comments within visual selection... this is useful
    autocmd FileType c,cpp vnoremap <localleader>dd :<c-u>execute "'<,'>g_^\s*//\(/\|\s*\|/[^/]\+.*\)$_d"
augroup END

" Autocmds for Python
augroup Python
    autocmd!
    autocmd FileType python setlocal cindent
    autocmd FileType python nnoremap <buffer> <localleader>c 0i#<esc>
    autocmd FileType python nnoremap <buffer> <localleader>uc :s!^\(\s*\)#!\1!ge<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!#!ge"<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^#!!ge"<cr>:nohlsearch<cr>
    autocmd FileType python inoreabbrev <buffer> iff if:<left>
    autocmd FileType python inoreabbrev <buffer> class class:<left>
    " Run the current file
    autocmd FileType python nnoremap <buffer> <F7> :!python %
augroup END

augroup Xml
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=99 foldminlines=0
augroup END

augroup vim_files
    autocmd!
    autocmd FileType vim nnoremap <buffer> <localleader>c 0i"<esc>
    autocmd FileType vim nnoremap <buffer> <localleader>uc :s!^\(\s*\)"!\1!ge<cr>:noh<cr>
    autocmd FileType vim vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!\"!ge"<cr>:nohlsearch<cr>
    autocmd FileType vim vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^\"!!ge"<cr>:nohlsearch<cr>
augroup END

augroup Project
    autocmd!
    autocmd BufRead proj_files.txt call ReplaceProjWithListing()
    autocmd BufRead proj_files.txt call UpdateWithIncludePaths()
    autocmd BufRead proj_files.txt setlocal foldmethod=indent foldlevelstart=0 foldminlines=0
    autocmd BufRead proj_files.txt nnoremap <buffer> <localleader>o :call OpenProjectFile(line("."))<cr>
    autocmd BufRead proj_files.txt nnoremap <buffer> <localleader>v :call OpenProjectFileInNextTab(line("."))<cr>
    autocmd BufRead proj_files.txt nnoremap <buffer> <localleader>b :call OpenProjectFile(line("."))<cr>call OpenSrcHeaderInVert(expand("%"))<cr>
augroup END

" Create a function to try to read a proj_files.txt and print it prettier in the current buffer
func! DisplayProjectFiles()
    let projFiles = readfile("./proj_files.txt")
    let ossep = '/'
    if has("win32")
        let ossep = '\\'
    endif

    let lineNr = 0
    for line in projFiles
        " If the line ends with :(G), then write it as is
        if match(line, "^\s*.*:(G)$") >= 0
            call append(lineNr, line)
        " Keep the tabbing, but take the filename from the end and put it up front, then move the path to afterwards and
        " put it inside of parens
        else
            let pattern = "^\\(\\s\\+\\)\\(.*".ossep."\\)\\(.*\\)"
            let rearranged = substitute(line, pattern, "\\1\\3; (\\2)", "")
            call append(lineNr, rearranged)
        endif

        let lineNr = lineNr + 1
    endfor

    execute "normal! Gdd"
endfunc

func! ReplaceProjWithListing()
    let bufNr = bufnr("%")
    edit ProjectListing
    execute "normal! ggvG\<end>d"
    execute "bd ".bufNr
    call DisplayProjectFiles()
endfunc

func! GetFileName(lineNr)
    let line = getline(a:lineNr)

    let ossep = "/"
    if has("win32")
        let ossep = "\\"
        let line = substitute(line, ossep, ossep.ossep, "")
    endif

    let splitLine = split(line, ";")
    let fileName = substitute(splitLine[0], "\\s*\\(.*\\)", "\\1", "")
    let pathName = substitute(splitLine[1], " (\\(.*\\))", "\\1", "")
    let fileName = pathName.fileName

    return fileName
endfunc

func! OpenProjectFile(lineNr)
    execute "tabedit ".GetFileName(a:lineNr)
endfunc


func! OpenProjectFileInNextTab(lineNr)
    let fileName = GetFileName(a:lineNr)
    tabnext
    execute "vsp ".fileName
endfunc

func! UpdateWithIncludePaths()
    let ossep = "/"
    if has("win32")
        let ossep = "\\"
    endif

    for line in readfile(".clang_complete")
        let includePath = substitute(line, '-\(I\|isystem \)"\(.*\)"', '\2', '')
        if includePath != line
            execute 'set path+='.escape(escape(escape(escape(includePath, ' '), '\ '), '('), ')')
        endif
    endfor
endfunc

func! OpenSrcHeaderInVert(thisFile)
    let ossep = "/"
    if has("win32")
        let ossep = "\\"
    endif

    let justFileName = split(a:thisFile, ossep)[-1:]
    let fileName = ""
    let newExts = []
    for item in split(justFileName[0], "\\.")
        if item == "h"
            call add(newExts, "c")
            call add(newExts, "cpp")
            break
        elseif item == "c"
            call add(newExts, "h")
            break
        elseif item == "hpp"
            call add(newExts, "cpp")
            break
        elseif item == "cpp"
            call add(newExts, "hpp")
            call add(newExts, "h")
            break
        else
            if fileName == ""
                let fileName = item
            else
                let fileName = fileName . "." . item
            endif
        endif
    endfor

    for ext in newExts
        let findName = join([fileName, ext], ".")
        try
            exe "vert sf ".findName
            break
        catch
            echom "Tried to open ".findName." but failed"
            continue
        endtry
    endfor

endfunc

func! RandInt()
    let output = ""
    redir => output
    python3 import random,time; random.seed(time.clock()); print(random.randint(0, 1000000))
    redir END
    let output = split(output, "\n")
    let @a = output[len(output)-1]
endfunc

" Finish off with a :noh
noh
