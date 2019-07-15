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
imap <c-]> {<cr>}<c-o>O<left><right>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

" Plugin
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/scrooloose/nerdtree'
call plug#end()



map ,n :NERDTreeToggle<cr>
