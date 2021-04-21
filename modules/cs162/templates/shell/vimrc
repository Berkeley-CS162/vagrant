" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Syntax highlighting always on
syntax on

" Detect filetype then load plugin file, set syntax highlighting,
" and set indentation accordingly
filetype plugin indent on

" Unix style line endings
set fileformat=unix

" Saves backup, swap, and undo files to ~/.vim/tmp instead of current directory
if !isdirectory($HOME . '/.vim/tmp')
    call mkdir($HOME . '/.vim/tmp', 'p', 0777)
endif

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set undodir=~/.vim/tmp

set swapfile      " keep a swap file
set backup        " keep a backup file (restore to previous version)
set undofile      " keep an undo file (undo changes after closing)
set history=1000  " keep 1000 lines of command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set autoread      " automatically reload a file if it is changed outside of vim


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
au!

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(':DiffOrig')
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If unset (default), this may break plugins (but it's backward
    " compatible).
    set langnoremap
endif

" Tab settings
set virtualedit=onemore " allow moving cursor one character past the end of the line
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2


set number " line numbers on
set laststatus=2 " Always show statusline

augroup override_filetype_detection
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
augroup END
