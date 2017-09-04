" sensible settings
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim
unlet! c_comment_strings
function! BuildColorCoded(info)
    if a:info.status == 'installed' || a:info.force
        !mkdir build && cd build && cmake .. && make && make install && make clean && make clean_clang
    endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('$HOME/.vim/plugged')
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
Plug 'rdnetto/YCM-generator', {'branch': 'stable'}
Plug 'jeaye/color_coded', {'do': function('BuildColorCoded'), 'for': ['c', 'cpp', 'objc', 'objcpp']}
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'raimondi/delimitmate'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
" Plug 'skywind3000/asyncrun.vim'
Plug 'sjl/Gundo.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'bsdelf/bufferhint'
Plug 'Shougo/denite.nvim'
Plug 'jiangmiao/auto-pairs'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gui display and colorsceme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
try
  set t_Co=256
  colorscheme eva01
catch
  colorscheme desert
endtry

if (&t_Co > 2 || has("gui_running")) && has("syntax")
    if has("unix")
        set guifont=Hack\ 14
    elseif has("win32")
        set guifont=Hack:h14
    endif
endif
set encoding=utf8
set ruler
set laststatus=2  " always show status line
set cmdheight=1   " height of cmd line
set number
set relativenumber
set so=7     " line to the cursor
set wildmenu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim general settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mapleader
let mapleader = ","
let maplocalleader = "\\"

" Filetype related, always on
filetype on
filetype plugin on
filetype indent on

" Vim only, no compatible with vi
set nocompatible
set backspace=eol,start,indent

set autoread " Auto read a file when changed outside

" This turns off all the bells in vim
set noerrorbells
set novisualbell
set t_vb=

set timeoutlen=500   " in miniseconds
set history=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" search options
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic
set showmatch

" turn off all backup
set nobackup
set nowb
set noswapfile

" indent setting
set autoindent
set smartindent
set wrap   " wrap lines
set linebreak  " break for very long line
set textwidth=500 " maximum length of line to tolerate

" tab/space setting
set expandtab  " use space instead of tabs
set smarttab
set shiftwidth=4
set tabstop=4

" fileformats
set fileformats=unix,dos,mac

" visual mode pressing * or # searches for the current selection
" super useful! from an idea by michael naumann
vnoremap <silent> * :<c-u>call visualselection('', '')<cr>/<c-r>=@/<cr><cr>
vnoremap <silent> # :<c-u>call visualselection('', '')<cr>?<c-r>=@/<cr><cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mapleader/fn related hotkeys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>w :w!<cr>
map <silent> <leader><cr> :noh<cr>
nnoremap <leader>. :lcd %:p:h<CR>  

nnoremap <silent> <F2> :NERDTreeToggle<cr>
nnoremap <silent> <F3> :TagbarToggle<cr>
nnoremap <silent> <F4> :call bufferhint#Popup()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" windows, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Traversing over windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l


" Traversing over tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" buffers
map <leader>l  :bnext<cr>
map <leader>h  :bprevious<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" hotkeys specific to plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeRespectWildIgnore=1
map <leader>nt :NERDTreeToggle<cr>
map <leader>nf :NERDTreeFind<cr>
map <leader>np :NERDTreeCWD<cr>
map <leader>nc :NERDTreeClose<cr>


" tagbar
let g:tagbar_autofocus = 1


" CtrlP
let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

" " Disable promping each time ycmd is used.
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_use_ultisnips_completer = 1

" NerdCommenter
" From https://github.com/scrooloose/nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Gundo
nnoremap <leader>gu :GundoToggle<cr>
let g:gundo_right=1
let g:gundo_close_on_revert=1

" ale
let g:ale_linters = {'cpp': ['clangtidy', 'cppcheck', 'clang', 'g++']}


" ale
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'

" bufferhint
" nnoremap <C-\> :call bufferhint#LoadPrevious()<cr>

" airline
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'deus'


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => Spell checking
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Pressing ,ss will toggle and untoggle spell checking
" map <leader>ss :setlocal spell!<cr>
"
" " Shortcuts using <leader>
" map <leader>sn ]s
" map <leader>sp [s
" map <leader>sa zg
" map <leader>s? z=


" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => helper functions
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
"
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
