
"{{{ 折行设置
    set fdm=marker
    set foldlevelstart=99
"}}}

" {{{ 语法高亮
    syntax enable
" }}}


set nocompatible
set backspace=indent,eol,start

" 显示行号 set nu(mber)
set nu

" 不自动折行
set nowrap

"{{{ 状态栏设置
    " 设置 laststatus = 0 ，不显式状态行
    " 设置 laststatus = 1 ，仅当窗口多于一个时，显示状态行
    " 设置 laststatus = 2 ，总是显式状态行
    set laststatus=2

    " 设置状态行显示常用信息
    " %F 完整文件路径名
    " %m 当前缓冲被修改标记
    " %m 当前缓冲只读标记
    " %h 帮助缓冲标记
    " %w 预览缓冲标记
    " %Y 文件类型
    " %b ASCII值
    " %B 十六进制值
    " %l 行数
    " %v 列数
    " %p 当前行数占总行数的的百分比
    " %L 总行数
    " %{...} 评估表达式的值，并用值代替
    " %{"[fenc=".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?"+":"")."]"} 显示文件编码
    " %{&ff} 显示文件类型
    set statusline=%F%m%r%h%w%=\ [ft=%Y]\ %{\"[fenc=\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\"+\":\"\").\"]\"}\ [ff=%{&ff}]\ [asc=%03.3b]\ [hex=%02.2B]\ [pos=%04l,%04v][%p%%]\ [len=%L]
"}}}

" 高亮当前行、列
" set cursorcolumn
set cursorline

"{{{ tab与缩进

    " tab 转换为4个空格
    set ts=4
    set expandtab

    " 设定>>与<<命令移动时的宽度
    set shiftwidth=4

    " 换行保持当前缩进
    set autoindent
"}}}


" 选择配色
" set t_Co=256

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


" 设置在状态行显示的信息

let mapleader=','
" Plugin
call plug#begin('~/.vim/plugins')
    Plug 'vim-latex/vim-latex'
    Plug 'https://github.com/scrooloose/nerdtree'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    Plug 'xuhdev/vim-latex-live-preview'
    Plug 'https://github.com/sirver/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'https://github.com/dhruvasagar/vim-table-mode'
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/scrooloose/nerdcommenter'
    Plug 'https://github.com/Yggdroot/LeaderF'
    Plug 'https://github.com/easymotion/vim-easymotion'
    Plug 'https://github.com/flazz/vim-colorschemes'
    Plug 'godlygeek/tabular'
    " Plug 'https://github.com/vim-scripts/vim-auto-save'
    Plug 'plasticboy/vim-markdown'
call plug#end()


" {{{ NerdTree
    map ,n :NERDTreeToggle<cr>
" }}}

" {{{ vim-colorschemes
    colorscheme molokai
" }}}

" {{{ My function
    function! GetUrl()   
        silent !python get_url.py
        silent redraw!
        normal "+p
    endfunction

    map <leader>p :call GetUrl()<cr>

    "map <leader>p :silent !python get_url.py<cr>

    "Fast reloading of the .vimrc
    nnoremap <leader>ss :source $MYVIMRC<cr>
    "Fast editing of .vimrc
    nnoremap <leader>ee :vs $MYVIMRC<cr>
    "When .vimrc is edited, reload it
    
    
    "function! Maximum()
        "set lines=999 columns=999
    "endfunction

    "function! Minimum()
        "set lines=25 columns=80
    "endfunction

     "map max :silent! call Maximum()<cr>
     "map min :silent! call Minimun()<cr>
" }}}

" {{{ LeaderF
    " 这个插件只记一个<leader><leader>s 就可以了
" }}}


"{{{ vim-table-mode
"   
    " 光标移动到已经存在的表格上 :TableFormat，可以格式化已经存在的表格。
"}}}
"
"
"
"{{{ vim-auto-save
    " let g:auto_save = 1
"}}}
"
"
"{{{ nagivate in the windows
    " 向下移动
    nnoremap <space>j <c-w>j
    " 向上移动
    nnoremap <space>k <c-w>k
    " 向左移动
    nnoremap <space>h <c-w>h
    " 向右移动
    nnoremap <space>l <c-w>l
"}}}


" {{{ vim-latex-preview
    autocmd Filetype tex setl updatetime=1000
    let g:livepreview_previewer = 'open -a skim'
    let g:livepreview_engine = 'xelatex --shell-escape'
" }}}
"
"
"{{{
    " 使grep总是生成文件名
    set grepprg=grep\ -nH\ $*
    " vim默认把空的tex文件设为plaintex而不是tex，导致latex-suite不被加载
    let g:tex_flavor='latex'
    set iskeyword+=:
    let g:Tex_CompileRule_pdf='xelatex --shell-escape -interaction=nonstopmode $*'
    let g:Imap_FreezeImap = 1

"}}}
"
"{{{
    let g:UltiSnipsExpandTrigger="<tab>"
    " 使用 tab 切换下一个触发点，shit+tab 上一个触发点
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<S-tab>"
    " 使用 UltiSnipsEdit 命令时垂直分割屏幕
"}}}
