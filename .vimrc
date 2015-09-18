" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
" runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim73/vimrc_example.vim or the vim manual
" and configure vim to your own liking!
set tabstop=4
set shiftwidth=4
set sts=4
set expandtab
set nocompatible
set encoding=utf8
set ffs=unix,dos,mac
set wrapscan
filetype on
filetype plugin on
filetype plugin indent on
syntax on
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set autoindent
"set si apparently depreciated
set cindent
set wrap
set noerrorbells"Disable back-up
set nobackup
set nowritebackup
set noswapfile
set tabpagemax=20
set relativenumber
set number

" Linebreak on 500 characters
set lbr
set tw=500

" Language specific
" Trailing spaces considered harmful
autocmd FileType c,cpp,python,ruby,haskell,go,coffee,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd FileType python set textwidth=72 formatoptions=c expandtab comments+=n:# cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setlocal completeopt-=preview

autocmd FileType ruby set tabstop=2 shiftwidth=2 expandtab textwidth=80 formatoptions=c comments+=n:#

autocmd FileType haskell set expandtab textwidth=80 formatoptions=c comments+=n:--
autocmd FileType coffee set tabstop=2 shiftwidth=2 expandtab textwidth=80 formatoptions=c comments+=n:#
"autocmd Bufenter *.hs compiler ghc

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

au BufRead /tmp/mutt-* set tw=72

set smarttab

" Search
set hlsearch
set incsearch

"Number of commands in history
set history=30

"Ignore case
set ignorecase
set smartcase

"Autoread when modified outside
set autoread

"Allow wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc

"Completion
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
highlight Pmenu ctermbg=DarkBlue
highlight PmenuSel ctermfg=White ctermbg=Blue cterm=Bold

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Show matching brackets/time of blink
set showmatch
set mat=2

set mouse=a

"Disable bell etc
"set noerrorbells
"au FileType python set omnifunc=python3complete#Complete
"
" Open NerdTree on start off empty program and close at last.
"autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

"let g:jedi#show_call_signatures=0
"let g:jedi#popup_on_dot=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_python_checkers=['prospector']
let g:syntastic_python_prospector_args = "-D -w frosted -w vulture"
"let g:syntastic_css_checkers=['prettycss']
let g:syntastic_cpp_checkers=['gcc', 'cppcheck']
let g:ctrlp_map = '<F3>'
let g:ycm_confirm_extra_conf = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'ubaryd'
let g:airline_powerline_fonts = 0
" Always show statusline
set laststatus=2

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_prompt='» '
let g:unite_split_rule = 'botright'
if executable('ag')
    let g:unite_source_grep_command='ag'
    let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
    let g:unite_source_grep_recursive_opt=''
endif

execute pathogen#infect()

call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :<C-u>Unite -no-split -buffer-name=files   -auto-preview -start-insert file_rec/async:!<cr>
nnoremap <F4> :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <F5> :<C-u>Unite -no-split -buffer-name=buffer  -quick-match buffer<cr>
nnoremap <F6> :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
 
