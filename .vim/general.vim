" General options for Vim editing environment



""" Basic options

filetype plugin indent on       " Load plugins and indent settings for active file
set nocompatible                " Disable compatibility with Vi


""" Vim interface options

set backspace=indent,eol,start  " Allow backspace to move cursor over everything
set belloff=all                 " Disable visual and audio error tones
set history=200                 " Set the size of command history
set nrformats-=octal            " Ignore octal numbers for <C-a>/<C-x> commands
set timeout timeoutlen=3000     " Timeout on user-defined mappings
set ttimeout ttimeoutlen=10     " Timeout on key code


""" Vim display options

set display=lastline            " Add @@@ at end of lines that do not fit on screen
set laststatus=2                " Display status line, even if there is only 1 file
set number                      " Display absolute line numbers on the left
set relativenumber              " Display the distance of every line from current
set scrolloff=10                " Scroll the screen before cursor reaches top/bottom
set showcmd                     " Displays command keystrokes on bottom right
set showmatch                   " Highlights matching brackets of any type


""" Colorscheme options

colorscheme moonfly
set background=dark
set termguicolors               " Enable true color support for terminal
syntax enable                   " Enable syntax highlighting


""" File options

autocmd BufEnter,FocusGained,CursorHold *
  \ checktime                   " Check and reload externally modified file
set autoread                    " Reload modified files (only after a command)
set encoding=utf-8              " UTF-8 File encoding
set hidden                      " Hide buffer instead of closing when switching out
set nobackup                    " Do not create backup files


""" Search options

set hlsearch                    " Highlight matches
set ignorecase                  " Ignores the case of search strings
set incsearch                   " See matches as you type (without pressing enter)
set smartcase                   " Do not ignore case if search string has uppercase
nmap <silent>
  \ ,/ :nohlsearch<CR>          " Clear highlights of previous matches


""" Command auto-completion options

set wildmenu                    " Enable command completion
set wildignorecase              " Ignore case when generating command matches
set wildmode=longest:full,full  " Customize command completion options
set wildignore=
  \*.swp,*.bak,*.pyc            " Ignore these file extensions in auto completion


""" Indentation options

set autoindent                  " Enable simple context-free automatic indentation
set expandtab                   " Convert tabs to spaces
set shiftwidth=2                " Indentation size in spaces
set softtabstop=2               " Behavior of <Tab> keystroke
set tabstop=2                   " File tab size in spaces (seen outside vim)
set textwidth=100               " Break lines at a length of 100 characters


""" Whitespace visualization options

set list                        " Display whitespace characters
set listchars=tab:>.,trail:.,extends:#,nbsp:.


""" Windows and splits options

set splitbelow                  " new horizontal split should open below current
set splitright                  " new vertical split should open to right of current
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


""" Custom user commands


" Close current file while keeping the window open
command -nargs=1 -complete=file E e <args> | bd#

" Save and exit current file, then open specified
command -nargs=1 -complete=file WE w | e <args> | bd#

" To save keystrokes in normal mode
nnoremap ; :

" Tab to cycle through autocomplete suggestions in INSERT mode
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

augroup vimStartup
  autocmd!
  " Begin editing at the last known cursor position
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit' |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Open diff comparison for current modified file and same unchanged file from disk
if !exists(":DiffOrig")
  command DiffOrig vert new | set buftype=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

