set nocompatible

filetype on

" vundle configuration
if has("win32")
    let g:vim_home_path = "~/vimfiles"
else
    let g:vim_home_path = "~/.vim"
endif

execute "set rtp+=" . g:vim_home_path . "/bundle/vundle/"
let g:vundle_default_git_proto = 'https'
call vundle#rc(g:vim_home_path. "/bundle")

" Bundles to install
Bundle 'gmarik/vundle'

"--------------------------------------------------
" vetted bunldles
"---------------------------------------------------
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'ervandew/supertab'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'airblade/vim-gitgutter'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'atom/fuzzy-finder'
Bundle 'ctrlpvim/ctrlp.vim'

scriptencoding utf-8
set encoding=utf-8

"------------------------------------------------
" Color settings
"------------------------------------------------
set background=dark

" Basic settings
highlight Normal                ctermfg=white ctermbg=NONE               guifg=white    guibg=#444444
highlight LineNr     cterm=bold ctermfg=gray  ctermbg=NONE      gui=NONE guifg=DarkGrey guibg=NONE
highlight Folded                ctermfg=59    ctermbg=NONE

" Pmenu for supertab etc
highlight Pmenu      cterm=NONE ctermfg=green ctermbg=darkgray  gui=NONE guifg=green guibg=darkgray
highlight PmenuSel   cterm=NONE ctermfg=green ctermbg=black     gui=NONE guifg=green guibg=black

" Better diff colors
highlight DiffAdd    cterm=bold ctermfg=black ctermbg=darkgreen gui=bold guifg=black guibg=darkgreen
highlight DiffChange cterm=bold ctermfg=black ctermbg=darkblue
highlight DiffText   cterm=bold ctermfg=black ctermbg=lightgray
highlight DiffDelete cterm=bold ctermfg=black ctermbg=darkred

" Underline the cursor line
highlight CursorLine ctermbg=red cterm=NONE guibg=darkgrey gui=NONE
:autocmd InsertEnter * highlight CursorLine ctermbg=NONE cterm=underline guibg=NONE gui=underline ctermfg=NONE
:autocmd InsertLeave * highlight CursorLine ctermbg=30  cterm=NONE guibg=30 gui=NONE ctermfg=NONE

" Extra white space
highlight OverLength      ctermbg=red
highlight ColorColumn     ctermbg=darkgray
highlight ExtraWhitespace ctermbg=red guibg=red


"------------------------------------------------
" Basic settings
"------------------------------------------------
let mapleader=","      " The leader key
set mouse=a            " Allow mouse
set nowrap             " No wrapping
set showmatch          " Show matching brackets when inserted
set splitbelow         " Default splits to below
set splitright         " Default vsplits to the right
set title              " Set title for gvim
set foldmethod=syntax  " Fold based on syntax
set foldlevel=999      " Start with folds open
set t_Co=256           " Force 256 colors
set scrolloff=999      " Keep cursor at center

" Syntastic settings
set statusline+=%#warningmsg#
"let g:syntastic_python_checkers=['pylint', 'flake8']
let g:syntastic_python_checkers=['pylint']
let g:syntastic_python_pylint_args='--rcfile=~/.pylintrc'
let g:syntastic_always_populate_loc_list = 1

" Tab settings
set expandtab          " Expand tabs into spaces
set smarttab           " Allow for easy backspace of tabs
set tabstop=4          " Use 4 spaces for tabs
set softtabstop=4      " Use 4 spaces for soft tabs
set shiftwidth=4       " Make shift same as a tab

" Indent settings
set autoindent
set nosmartindent

" Search settings
set hlsearch           " Highlight results
set incsearch          " Start showing results while typing
set ignorecase         " Ignore case in searched
set smartcase          " Use case in search with capitals

" Line number settings
set number     " Start with relative numbers
set numberwidth=3      " Use 3 columns for numbers

" Cursor / visual settings
set cursorline         " Show a line for the cursor
set colorcolumn=       " Unset colorcolumn
set laststatus=2       " Always show status line
set showmode           " Show the current mode

" Tab completion settings
set wildmode=list:longest     " Complete till longest common string
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.pyc         " Ignore python compiled files
set wildignore+=*.class       " Ignore java compiled files
set wildignore+=*.swp         " Ignore vim backups

" Backup/Undo settings
execute "set directory=" . g:vim_home_path . "/swap"
execute "set backupdir=" . g:vim_home_path . "/backup"
execute "set undodir=" . g:vim_home_path . "/undo"
set backup
set undofile
set writebackup


"------------------------------------------------
" Plugin settings
"------------------------------------------------

" SuperTab settings
let g:SuperTabDefaultCompletionType = "context"

" NerdTree settings
let g:nerdtree_tabs_open_on_console_startup = 1
let NERDTreeShowHidden=1

" Powerline settings
let g:Powerline_symbols = 'fancy'

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=84
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=51

"------------------------------------------------
" Other settings
"------------------------------------------------
" Auto save and restore views for these files
autocmd BufWinLeave *.sh mkview
autocmd BufWinEnter *.sh silent loadview
autocmd BufWinLeave *.c mkview
autocmd BufWinEnter *.c silent loadview
autocmd BufWinLeave *.h mkview
autocmd BufWinEnter *.h silent loadview
autocmd BufWinLeave *.h mkview
autocmd BufWinEnter *.h silent loadview
autocmd BufWinLeave *.py mkview
autocmd BufWinEnter *.py silent loadview
autocmd BufWinLeave *.java mkview
autocmd BufWinEnter *.java silent loadview
autocmd BufWinLeave *.js mkview
autocmd BufWinEnter *.js silent loadview
autocmd BufWinLeave *.coffee mkview
autocmd BufWinEnter *.coffee silent loadview
autocmd BufWinLeave *.sls mkview
autocmd BufWinEnter *.sls silent loadview
autocmd BufWinLeave *.rst mkview
autocmd BufWinEnter *.rst silent loadview

" Treat all html as htmldjango
autocmd BufNewFile,BufRead *.html set filetype=htmldjango

" Show extra which space and over 120
match OverLength /\%120v.\+/
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Fun with numbers
autocmd FocusLost * :set number
autocmd FocusGained * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set number
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc

" Short cuts for split nav
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Easier visual indent
vnoremap < <gv
vnoremap > >gv

" Command to write as root if forgot to open with sudo
cmap w!! %!sudo tee > /dev/null %

imap kj <ESC>

" Key bindings
noremap <silent><leader>/ :nohlsearch<Bar>:echo<CR>
nnoremap <F2> :call NumberToggle()<cr>
map <F3> :set wrap! wrap?<CR>
map <F4> :set hlsearch! hlsearch?<CR>
map <F5> :edit <CR>
map <F6> :edit! <CR>
nmap <F12> :NERDTreeTabsToggle <CR>
map <F8> :set expandtab! expandtab?<CR>
map <F9> :set paste! paste?<CR>
map <F10> :set cursorline! cursorline?<CR>
map <F11> :set spell! spell?<CR>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
map <silent> <C-n> :NERDTreeMirrorToggle<CR>
map <silent> <C-i> :IndentGuidesToggle<CR>
map <silent><leader>e :lnext<CR>
nmap <CR> i<CR><Esc>
