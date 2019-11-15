"""""""""""""""""""""""""""""""
""""" Very General Boilerplate
"""""""""""""""""""""""""""""""
set shell=/bin/bash "" Fish doesn't work well in vim, apparently

set vb t_vb=        "" No beeping
set shortmess+=c    "" Don't give |ins-completion-menu| messages
set nocompatible    "" Don't try to be compatible with very old vim

" Use space for leader
let mapleader = "\<Space>"
" Quick editing and reloading of this file
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

"""""""""""""""""""""""""""""""
""""" Plugins
"""""""""""""""""""""""""""""""

" Install plugged if it's not installed yet
if has("nvim") && empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" General purpose
Plug 'airblade/vim-rooter'                       "" cd to git root
Plug 'junegunn/fzf',                             "" fuzzy file finder
  \ { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'down': '~20%' }

" GUI Enhancements
Plug 'itchyny/lightline.vim'                     "" Bottom bar
let g:lightline = { 'colorscheme': 'one', }

Plug 'machakann/vim-highlightedyank'             "" Highlight yanked text
Plug 'godlygeek/tabular'                         "" Line things up with tabs
Plug 'chriskempson/base16-vim'                   "" Base16 color schemes
Plug 'felixhummel/setcolors.vim'                 "" Quick switch of color schemes

" Extra motions
Plug 'justinmk/vim-sneak'                        "" 2-character motion
let g:sneak#s_next = 1                           "" s to continue cyling a sneak search
Plug 'andymass/vim-matchup'                      "" Better % with language-specific features

" Language services
Plug 'w0rp/ale'                                  "" Like Syntastic, language services
" Setup hotkeys
" Ctrl-k  previous error
" Ctrl-j  next error
" Shift-L check for errors
" Ctrl-L  give detailed information about error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> L <Plug>(ale_lint)
nmap <silent> <C-l> <Plug>(ale_detail)

" ncm2 stuff
Plug 'ncm2/ncm2'                                 "" Autocompletion
Plug 'roxma/nvim-yarp'                           "" Remote Plugin framework used by ncm2
Plug 'ncm2/ncm2-bufword'                         "" Adds words from the current buffer to ncm2
Plug 'ncm2/ncm2-tmux'                            "" Adds words from other tmux panes to ncm2
Plug 'ncm2/ncm2-path'                            "" Adds file paths to ncm2

" Settings for ncm2
autocmd BufEnter * call ncm2#enable_for_buffer() "" Enable ncm2 on all buffers
set completeopt=noinsert,menuone,noselect        "" Required completeopt for ncm2
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Filetype language support
"  Configuration files
Plug 'cespare/vim-toml'        "" toml language support
Plug 'plasticboy/vim-markdown' "" markdown support (Note: must be after tabular)
"  Programming Languages
Plug 'rust-lang/rust.vim'      "" Official rust language support
"  Shell files
Plug 'dag/vim-fish'            "" Fish scripting language support

call plug#end()


"""""""""""""""""""""""""""""""
""""" Other Settings
"""""""""""""""""""""""""""""""

" General Settings
set hidden                                                    "" Keep things open in a hidden buffer
set nowrap                                                    "" Don't visually wrap lines
set nojoinspaces                                              "" Don't insert double spaces, it's outdated

" Colors
syntax on
if !has('gui_running')
  set t_Co=256
endif

" Window layout
set guioptions-=T                                             "" Remove toolbar
set noshowmode                                                "" Don't show the mode, since we have lightline
set ruler                                                     "" Line/column numbers in footer
set laststatus=2                                              "" Always render the status line
set showcmd                                                   "" Render the partial command in the status line
set relativenumber                                            "" Relative line numbers
set number                                                    "" Show the current line as absolute
set colorcolumn=80                                            "" and give me a colored column
highlight ColorColumn ctermbg=7
highlight ColorColumn ctermbg=248 ctermfg=232 guibg=LightGray
set signcolumn=yes                                            "" Always show the debugger/error gutter
set splitright                                                "" Split a new pane to the right (default is left)
set splitbelow                                                "" Split a new pane to the bottom (default is top)
set expandtab                                                 "" Use spaces, not tabs
set tabstop=2                                                 "" Tab based indentation indents by 2 characters

" The wildmenu is what appears for autocompletions
" Turn it on, then set the mode
"  - On first tab, show the list and autocomplete
set wildmenu
set wildmode=longest:list,full
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Editing
set timeoutlen=400                                "" Vim has weird normal-mode delay because key chords
set ttimeoutlen=100
set backspace=2                                   "" Backspace over newlines
set foldmethod=marker                             "" Fold only on marks
set mouse=a                                       "" Always enable the mouse
set nolist                                        "" Render whitespace
set listchars=nbsp:¬,extends:»,precedes:«,trail:•
set encoding=utf-8                                "" utf-8 encoding
set scrolloff=5                                   "" Keep 5 lines above or below the cursor when possible
set undodir=~/.vimdid                             "" This and the next line enable infinite/permanent undo
set undofile
set clipboard=unnamed                             "" Use the system clipboard
set shiftwidth=2                                  "" Indent by two spaces (NOTE: should always be the same as tabstop

if has('wsl')
  " On WSL, keep system clipboard updated
  augroup Yank
    autocmd!
    autocmd TextYankPost * :call system('clip.exe ',@")
  augroup END

  " And make the visual cursor work with WSL
  " NOTE: Doesn't actually work...
  " https://github.com/Maximus5/ConEmu/issues/937#issuecomment-421426600
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[4 q"
  let &t_EI.="\e[1 q"
endif

" Better diffing
" https://vimways.org/2018/the-power-of-diff/
set diffopt+=iwhite                             "" No whitespace in vimdiff
set diffopt+=algorithm:patience                 "" The "patience" diff algorithm
set diffopt+=indent-heuristic                   "" Try to ignore indentation changes

" Searching
set incsearch                                   "" Show search results incrementally
set ignorecase                                  "" Ignore case when searching,
set smartcase                                   "" However, if we include capital letters, be case sensitive
set gdefault                                    "" make substitutions search globally by default

" Fix a redraw issue with relative line numbers
set ttyfast
set lazyredraw
set regexpengine=1
set synmaxcol=500

                                                "" neovim specific settings
if has("nvim")
  " Change the cursor in different modes
  " n-v-c:                                      "" In normal, visual, and command-line normal (append) modes
  " block-Cursor/lCursor-blinkon0,              "" Use an unblinking block cursor using the Cursor colors
  " i-ci:                                       "" In insert and Command-line insert modes
  " ver24-Cursor/lcursor                        "" Use a blinking 24% width cursor using the cursor colors
  " r-cr:                                       "" In replace and rommand-line replace mode
  " hor20-Cursor/lcursor                        "" Use a blinking 20% height cursor using the cursor colors
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
end

"""""""""""""""""""""""""""""""
""""" Keyboard Shortcuts
"""""""""""""""""""""""""""""""

" Swap between most recent buffers
nnoremap <Leader><Leader> <c-^>
" Quick save
nmap <Leader>w :w<CR>
" Quick buffer
nmap <Leader>s :Buffers<CR>
" Quick open
nmap <Leader>o :Files<CR>

" easier commands
nnoremap ; :
" Easier beginning and end of line 
map H ^
map L $

" Center things by applying zz after various keypresses
" The <silent> suppresses nzz from being displayed at the bottom
" n - next search result
" N - previous search result
" * - search for the word under the current cursor
" # - search backwards for the word under the current cursor
" g* - search for the word under the current cursor (even inside other words)
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" Use escape to clear the search buffer
nnoremap <silent> <esc> :noh<return><esc>

" Turn on "very magic" mode by default, which means regexes prefer special
" characters, and must be escaped for normal characters
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Move by visual line, instead of physical line, for word wrapping
nnoremap j gj
nnoremap k gk

