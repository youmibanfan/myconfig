set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8

set number
set relativenumber
let mapleader=' '
map <LEADER>p "+p
map <LEADER>y "+y

set ruler
set showcmd

set foldenable
set foldmethod=manual


map R :source $MYVIMRC<CR>
map S :w<CR>
map Q :q<CR>
noremap J 5j
noremap K 5k
noremap H 0
noremap L $


" List Buffers 查看当前所有的buffer 
noremap lb :ls b<CR>

" Buffer Next 下一个buffer
noremap bn :bn<CR>

" Buffer Previous 上一个buffer
noremap bp :bp<CR>

" Buffer Down 关闭当前buffer
noremap bd :bd<CR>

" Buffer number 指定第二个buffer
" :b 2



map <C-A> ggVG

set completeopt=preview,menu
set clipboard+=unnamed
set autowrite
set autoread
set cursorline

set wrap
set confirm

set autoindent
set cindent
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set smartcase
set ignorecase
set hlsearch
set incsearch
noremap <LEADER><CR> :nohlsearch<CR>
noremap <LEADER>: :normal 

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
set helplang=cn

set mouse=a
set selectmode=mouse,key
set selection=exclusive
set showmatch
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
set textwidth=0
set indentexpr=
set foldmethod=indent
set foldlevel=99

inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

let &t_ut=''
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir

set backspace=indent,eol,start
set wildmenu 
" === Restore Cursor Position
augroup BUfReadPost
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

map el :set splitright<CR>:vsplit<CR>
map eh :set nosplitright<CR>:vsplit<CR>
map ek :set nosplitbelow<CR>:split<CR>
map ej :set splitbelow<CR>:split<CR>
map ev <C-w>t<C-w>H
map ei <C-w>t<C-w>K

map ep :set paste<CR>
map eo :set nopaste<CR>
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
"set spell



map <LEADER><up> :res +5<CR>
map <LEADER><down> :res -5<CR>
map <LEADER><left> :vertical resize -5<CR>
map <LEADER><right> :vertical resize +5<CR>

" Open the vimrc file anytime
map <LEADER>rc :e ~/.vim/vimrc<CR>
" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec 'w'
  if &filetype ==# 'c'
    exec '!g++ % -o %<'
    exec '!time ./%<'
  elseif &filetype ==# 'cpp'
    silent! exec '!clear'
    exec '!g++ % -o %<'
    silent! exec '!clear'
    exec '!time ./%<'
  elseif &filetype ==# 'java'
    exec '!javac %'
    exec '!time java %<'
  elseif &filetype ==# 'sh'
    :!time bash %
  elseif &filetype ==# 'python'
    #silent! exec '!clear'
    exec 'clear'
    exec '!time python3 %'
    silent! exec '!clear'
  elseif &filetype ==# 'html'
    exec '!firefox % &'
  elseif &filetype ==# 'markdown'
    exec 'MarkdownPreview'
  elseif &filetype ==# 'vimwiki'
    exec 'MarkdownPreview'
  endif
endfunc

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'beikome/cosme.vim'
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'

call plug#end()
""=====airline=======================================
""=====airline=======================================
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'



""=====nerdtree=======================================
""=====nerdtree=======================================
map nt :NERDTreeToggle<CR>

""=====autopair=======================================
""=====autopair=======================================

augroup autopair
au Filetype FILETYPE let b:AutoPairs = {"(": ")"}
au FileType php      let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})

augroup END

""=====ale=======================================
""=====ale=======================================
" let g:ale_sign_column_always = 1
let g:ale_sign_error = ':)'
let g:ale_sign_warning = '^^'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SignColumn
" Set this in your vimrc file to disabling highlighting
" let g:ale_set_highlights = 0
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Write this in your vimrc file
"let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" You can disable this option too
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0



""=====autopair=======================================















