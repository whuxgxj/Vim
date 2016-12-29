" *********************************************
" Vbundle
" *********************************************
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline-themes'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" *********************************************
" 解决delete键不能向左删除
" *********************************************
:set backspace=2
set clipboard=unnamed
" *********************************************
" 分割布局相关
" *********************************************
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" *********************************************
" ctrlp
" *********************************************
let g:ctrlp_map = '<c-p>' 
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名 
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$' 
" *********************************************
" 代码折叠
" *********************************************
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1
" *********************************************
" python代码风格PEP8
" *********************************************
au BufNewFile,BufRead *.py set tabstop=4 |set softtabstop=4|set shiftwidth=4|set textwidth=79|set expandtab|set autoindent|set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2|set softtabstop=2|set shiftwidth=2

" *********************************************
" 标记空白字符
" *********************************************
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/ 


" *********************************************
" 支持UTF-8编码
" *********************************************
set encoding=utf-8

" *********************************************
" YCM插件相关
" *********************************************
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>'] 
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>'] 
let g:ycm_auto_trigger = 1 
"*********************************************
" 支持Python虚拟环境
" *********************************************
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" *********************************************
" 配色和高亮
" *********************************************
let python_highlight_all=1
syntax on

set t_Co=256
set background=dark
colorscheme Tomorrow-Night
" 开启行号
set nu
" *********************************************
" NERD插件属性
" *********************************************
au vimenter * NERDTree

" *********************************************
" vim-airline
" *********************************************
let g:airline_powerline_fonts = 1
set guifont=Source\ Code\ Pro\ for\ Powerline:h14

set laststatus=2 
let g:Powerline_symbols='fancy'  
"*********************************************
" 一键执行
" *********************************************
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "W"
    if &filetype =='c'
	exec "!gcc % -o %<"
	exec "!time ./%<"
    elseif &filetype=='cpp'
	exec "!g++ % -o %<"
	exec "!time ./%<"
    elseif &filetype == 'Python'
        exec "!time python3 %"
    endif
endfunc
"*********************************************
" Tagbar配置
" *********************************************
map <F9> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_auto_faocus =1 
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
