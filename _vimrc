set nocompatible              " be iMproved, required
filetype off                  " required

" Load the clearcase plugin
let UsingClearCase = 0

" Control bitness
let NumBits = 32

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

" Best window swapper
Plugin 'wesQ3/vim-windowswap'

" Clang based code completion for C++
Plugin 'Rip-Rip/clang_complete'

" Tab completion, for better auto complete
Plugin 'ervandew/supertab'

" Clearcase plugin, but only on the work computer
if (UsingClearCase != 0)
    Plugin 'ccase.vim'

    " Add some handy shortcuts, such as opening the version tree and diffing with predecessor
    nnoremap <F6> :Ctxlsv<cr>
    nnoremap <F7> :Ctpdif<cr>:set ft=cpp<cr><c-w>lgg
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

if has("win32")
    " Specify the clang installation
    if NumBits == 32
        let g:clang_library_path='C:\Program Files (x86)\LLVM\bin\libclang.dll'
    elseif NumBits == 64
        let g:clang_library_path='C:\Program Files\LLVM\bin\libclang.dll'
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
let g:clang_user_options='-std=c++11'
let g:clang_auto_user_options=".clang_complete"

" Uncomment in case of emergency
"let g:clang_debug = 1

let g:SuperTabDefaultCompletionType = "<c-x><c-u>"

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

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use DOS as the standard file type
set ffs=unix,dos,mac

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

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

" Linebreak on 500 characters
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

" Map jk to esc in order to save my knuckles
inoremap jk <esc>

" Make some cool mappings for home, end, pgup and pgdown
noremap <leader>h ^
nnoremap <leader>l $
vnoremap <leader>l $h
noremap <leader>j <PageDown>
noremap <leader>k <PageUp>

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

" Make switching  between multiple buffers better
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-h> <esc><c-w>h
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-l> <esc><c-w>l

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
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

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

" Extend the line with the last character out to 120 columns
nnoremap    <leader>ec <end>vy120p<esc>d120\|^<cr>

" Go to the last character in the file
nnoremap G   G<End>
vnoremap G   G<End>

" Insert and append a single character in normal mode
nnoremap <leader>i  vyphr
nnoremap <leader>a  vypr

" Mapping to close the preview and quickfix windows
inoremap <c-q> <esc>:pc<cr>:ccl<cr>a
nnoremap <leader>q :pc<cr>:ccl<cr>

" Open file under cursor in a vertical split - replace the default mapping
nnoremap <c-w>f :vert wincmd f<cr>

" Insert the correctly formatted date in insert mode
inoremap <F3> <C-R>=strftime("%d-%b-%Y")<CR>
inoremap <F2> <C-R>=$USERNAME<CR><esc>vbuea

" Substitute word under cursor
nnoremap <leader>s yiw:%s/<c-r>"/
nnoremap <leader>S yiW:%s/<c-r>"/

" Replace word/WORD under cursor
nnoremap <leader>r "gyiw"0Plde
nnoremap <leader>R "gyiW"0PldE

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
else
    set dict+=/usr/share/dict/words
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File Specific Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocmds for C and C++
augroup CAndCpp
    autocmd!
    " Use doxygen syntax highlighting on top of C++ syntax highlighting
    autocmd BufReadPre cpp let g:load_doxygen_syntax=1
    " Do not indent goto labels
    autocmd FileType cpp setlocal cinoptions+=Ls
    " Do not indent inside of a namespace
    autocmd FileType cpp setlocal cinoptions+=N-s
    " Do not indent cases inside of a switch
    autocmd FileType cpp setlocal cinoptions+=:0
    " Align the insides of a case label with the case lable
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
    " Insert an if statement with curly braces when typing iff
    autocmd FileType cpp inoreabbrev <buffer> iff if ()<cr>{<cr>}<up><up><end><left>
    " Insert a basic counter based for loop with curly braces by typing fori
    autocmd FileType cpp inoreabbrev <buffer> fori for (std::uint8_t i = 0U; i <; ++i)<cr>{<cr>}<up><up><end><left><left><left><left><left><left>
    " Insert a case of a switch statement
    autocmd FileType cpp inoreabbrev <buffer> casee case:<cr><cr>break;<up><up><end><left>
    " Try to be smart (more like foolish) about wrapping things inside of an if with parens
    autocmd FileType cpp nnoremap <buffer> <localleader>( mn?[&\|=<>]<cr>wi(<esc>/[;)]$<cr>i)<esc>`nl:noh<cr>
    " Try to be smart (more like foolish) about wrapping things inside of an if with parens
    autocmd FileType cpp nnoremap <buffer> <localleader>) mn/[&\|=<>]<cr>bea)<esc>?[(]<cr>a(<esc>`nl:noh<cr>
    " Swap the statements on either side of the equals sign
    " (the qaq and qsq starting the mapping are to clear out the a and s registers, which are used here)
    autocmd FileType cpp nnoremap <buffer> <localleader>se qaqqsq^"adt=lp"sdt;F=hhp
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
    " Format the body of a code block
    autocmd FileType cpp nnoremap <buffer> <localleader>f mm/{<cr><S-v>%=:noh<cr>`m
    " Count comment header/delimiter thingy lines
    autocmd FileType cpp nnoremap <buffer> <localleader>cc :%s/^\s*\/\/[\/\*]\{20,117}$//gn<cr>
augroup END

" Autocmds for Python
augroup Python
    autocmd!
    autocmd FileType python setlocal cindent
    autocmd FileType python nnoremap <buffer> <localleader>c 0i#<esc>
    autocmd FileType python nnoremap <buffer> <localleader>uc :s!^\(\s*\)#!\1!ge<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>c :<c-u>execute "'<,'>s!^!#!ge"<cr>:nohlsearch<cr>
    autocmd FileType python vnoremap <buffer> <localleader>uc :<c-u>execute "'<,'>s!^#!!ge"<cr>:nohlsearch<cr>
    autocmd FileType python :iabbrev <buffer> iff if:<left>
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

" Finish off with a :noh
noh
