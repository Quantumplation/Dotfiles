" .vimrc
set encoding=utf-8

if &term == "screen"
  set t_Co=256
endif

" load up pathogen and all bundles
call pathogen#infect()
call pathogen#helptags()

syntax on                         " show syntax highlighting
filetype plugin indent on
set smartindent                   " Smart indentation based on code
set autoindent                    " set auto indent
set ts=2                          " set indent to 2 spaces
set shiftwidth=2
set expandtab                     " use spaces, not tab characters
set nocompatible                  " don't need to be compatible with old vim
set relativenumber                " show relative line numbers
set mouse=a                       " Mouse support (makes line numbers work better)
set noshowmatch                   " show bracket matches
set ignorecase                    " ignore case in search
set hlsearch                      " highlight all search matches
set cursorline                    " highlight current line
set smartcase                     " pay attention to case when caps are used
set incsearch                     " show search results as I type
set ttimeoutlen=100               " decrease timeout for faster insert with 'O'
set vb                            " enable visual bell (disable audio bell)
set ruler                         " show row and column in footer
set scrolloff=2                   " minimum lines above/below cursor
set laststatus=2                  " always show status bar
set list listchars=tab:»·,trail:· " show extra space characters
set nofoldenable                  " disable code folding
set clipboard=unnamed             " use the system clipboard
set wildmenu                      " enable bash style tab completion
set wildmode=list:longest,full
runtime macros/matchit.vim        " use % to jump between start/end of methods


" put status, column/row number, total lines, and percentage in status
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]

set background=dark
colorscheme vimbrant
set colorcolumn=80
highlight ColorColumn ctermbg=7
highlight ColorColumn ctermbg=248 ctermfg=232 guibg=LightGray

highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight LineNr       ctermbg=236 ctermfg=240
highlight CursorLineNr ctermbg=236 ctermfg=240
highlight CursorLine   ctermbg=236
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=250 ctermfg=8
highlight IncSearch    ctermbg=3   ctermfg=1
highlight Search       ctermbg=1   ctermfg=3
highlight Visual       ctermbg=3   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

" highlight the status bar when in insert mode
if version >= 700
  au InsertEnter * hi StatusLine ctermbg=238 ctermfg=2
  au InsertLeave * hi StatusLine ctermbg=250 ctermfg=8
endif

set updatetime=500
set cmdheight=2

set hidden
set runtimepath^=~/.vim/bundle/ctrlp.vim
