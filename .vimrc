" Mostly based on the example wikia file
" URL: http://vim.wikia.com/wiki/Example_vimrc
" plus meir krihali dotvim
" https://github.com/MeirKriheli/dotvim/blob/master/vimrc
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

  " Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
" mystuff:

set nocompatible
" pathogen installation - handles all the plugins
call pathogen#incubate()

call pathogen#helptags()
" execute pathogen#infect()
colorscheme base16-default
set background=dark

" map ctrl p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" default script:

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
filetype plugin on
" Enable syntax highlighting
syntax on

" Keep swap files out of the working dir
" Adjust if needed in another dir
set directory=~/tmp
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch   " highlights search and remove highlight <f4>
set incsearch   
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" pairs
set matchpairs+=<:>     " show matching <> (html mainly) as well
set showmatch
set matchtime=3
set sm             

" status line tweaking

set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

" Columns and lines
set colorcolumn=80

if has("gui_running")
    set lines=75
    set columns=180
endif

" Maps for jj to act as Esc in insert and command modes
ino jj <esc>
cno jj <c-c>

" map leader to ,
let mapleader=","
" ==================================================

"
" ==================================================

let g:pymode_lint_ignore = "W0611"

" ==================================================
" NERDTree
" ==================================================

let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
map <F3> :NERDTreeToggle<CR>

" ====================================================
" NERDCommenter
" ====================================================
" map comment toggle to F7
map <F7> <leader>ci
"==================================================
"Omni Completion
"==================================================

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" ==================================================
" SuperTab
" ==================================================

let g:SuperTabDefaultCompletionType = "context"


" ==================================================
" CtrlP
" ==================================================

set wildignore+=*.so,*.swp,*.zip,*.pyc,*.pyo
let g:ctrlp_custom_ignore = 'node_modules\|bower_components'

" ==================================================
" Ack
" ==================================================

nmap g/ :Ack<space>
nmap g* :Ack -w <C-R><C-W><space>
nmap ga :AckAdd!<space>

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
noremap <F4> :set hlsearch! hlsearch?<CR>
"
" ==================================================
" undo tree visual navigation navigation
" ==================================================

noremap <F5> :GundoToggle<CR>

" ==================================================
" nginx config 
" ==================================================
autocmd BufRead,BufNewFile /etc/nginx/sites-*/* setfiletype conf

" ==================================================
" Window navigation
" ==================================================

" control + vim direction key to navigate windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" control + arrow key to navigate windows
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
noremap <C-Left> <C-W>h
noremap <C-Right> <C-W>l

" <C-TAB> and <C-S-TAB> to switch buffers " in the current window
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>
"
" ==================================================
" Splits handling
" ==================================================

" Make these all work in insert mode
imap <C-W> <C-O><C-W>

" - and + to resize horizontal splits
map - <C-W>-
map + <C-W>+

" alt-< or alt-> for vertical splits
map <m-,> <C-W>>
map <m-.> <C-W><

" And for gnome terminal etc
map , <C-W>>
map . <C-W><

" F2 close current split (window)
noremap <F2> <Esc>:close<CR><Esc>


" ==================================================
" Right-to-Left (Hebrew etc) shortcuts
" ==================================================

" toggle direction mapping
" this is useful for logical-order editing
map <F9>   :set invrl<CR>
" do it when in insert mode as well (and return to insert mode)
imap <F9> <Esc>:set invrl<CR>a

" toggle reverse insertion
" this is useful for visual-order editing
map <F8>   :set invrevins<CR>
" do it when in insert mode as well (and return to insert mode)
imap <F8> <Esc>:set invrevins<CR>a

" Allow overrides via ~/.vim/vimrc.local
if filereadable(expand("~/.vim/vimrc.local"))
    source ~/.vim/vimrc.local
endif
"------------------------------------------------------------

