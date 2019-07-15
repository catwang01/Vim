
" 显示行号 set nu(mber)
set nu

" tab 转换为4个空格
set ts=4
set expandtab

" 换行保持当前缩进
set autoindent

" 选择配色
colorscheme desert 

" 语法高亮
syntax enable 
syntax on

" 编码问题
set encoding=utf8

" 自动补全相关
" imap <c-]> {<cr>}<c-o>O<left><right>
" inoremap ( ()<LEFT>
" inoremap [ []<LEFT>
" inoremap { {}<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
"

let mapleader=','
" Plugin
call plug#begin('~/.vim/plugged')
        Plug 'https://github.com/scrooloose/nerdtree'
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
        Plug 'https://github.com/dhruvasagar/vim-table-mode'
        Plug 'https://github.com/tpope/vim-surround'
        Plug 'https://github.com/scrooloose/nerdcommenter'
        Plug 'https://github.com/Yggdroot/LeaderF'
call plug#end()



map ,n :NERDTreeToggle<cr>

