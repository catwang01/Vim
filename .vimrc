"{{{ 折行设置
set fdm=marker
set foldlevelstart=99
"}}}

" {{{ 语法高亮
syntax enable
" }}}

" 取消bell，用屏幕闪烁代替
set vb

set backup
set backupext=.back
set backupdir=~/.vim/backupfiles
set nocompatible
set backspace=indent,eol,start

" 显示行号 set nu(mber)
set nu

" 查找高亮
set hlsearch
" 忽略大小写
set ignorecase

" 不自动折行
set nowrap
"set wrap

" conceal
set conceallevel=0

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
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936


" 自动补全相关
"imap <c-]> {<cr>}<c-o>O<left><right>
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>

" 设置在状态行显示的信息

function! Checkpath()
pythonx << EOF
import os
import vim
def check(path):
    if not os.path.exists(path):
        os.makedirs(path)
        print("{} has been created!".format(path))
home = vim.eval("$HOME")
autoloadpath = os.path.join(home, ".vim/autoload")
backupdir= os.path.join(home, ".vim/backupfiles")
check(autoloadpath)
check(backupdir)
EOF
endfunction
call Checkpath()

function! DownloadVimPlug()
pythonx << EOF
import os
import vim
import os
autoloadpath = os.path.join(home, ".vim/autoload")
downloadpath = os.path.join(autoloadpath, "plug.vim")
if not os.path.exists(downloadpath): 
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    print("Downloading Vim Plug\n\n")
    os.system("curl {} -o {}".format(url, downloadpath))
EOF
endfunction
call DownloadVimPlug()

let mapleader=','
" Plugin
call plug#begin('~/.vim/plugins')
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
"Plug 'https://github.com/ycm-core/YouCompleteMe'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'xuhdev/vim-latex-live-preview'
"Plug 'https://github.com/sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/Yggdroot/LeaderF'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'skywind3000/asyncrun.vim'
" Plug 'https://github.com/vim-scripts/vim-auto-save'
Plug 'plasticboy/vim-markdown'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
call plug#end()


" {{{ NerdTree
    map ,n :NERDTreeToggle<cr>
    let NERDTreeShowBookmarks=1
    "设置忽略文件类型"
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
    "窗口大小"
    let NERDTreeWinSize=30

    " 关闭vim时，如果打开的文件除了NERDTree没有其他文件时，就自动关闭
    " [NERDTree插件（vim笔记三） - 简书](https://www.jianshu.com/p/eXMxGx)
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
" }}}

" {{{ vim-colorschemes
    colorscheme molokai
" }}}


"{{{
    " 自动打开 quickfix window ，高度为 6
    let g:asyncrun_open = 6

    " 任务结束时候响铃提醒
    let g:asyncrun_bell = 1
"}}}

"
" {{{ My function

"   """"""""""""""""""""""
"Quickly Run
""""""""""""""""""""""
map <F5> :call QuickRun()<CR>
imap <F5> <ESC>:call QuickRun()<CR>
map run :call QuickRun()<CR>

imap <c-r> <ESC>:call QuickRun()<CR>
map <c-r> :call QuickRun()<CR>

func! QuickRun()
    exec "w"
    if &filetype == 'c'
        exec ":AsyncRun gcc-9 % -fopenmp -o /tmp/%< && /tmp/%<"
    elseif &filetype == 'cpp'
        "exec ":AsyncRun make"
        exec ":AsyncRun g++-9 % -o /tmp/a.out --std=c++11 -fopenmp && /tmp/a.out"
    elseif &filetype == 'java'
        exec ":AsyncRun javac %"
        "elseif &filetype == 'sh'
        "::AsyncRun time bash %
    elseif &filetype == 'python'
        exec ":AsyncRun python %"
    elseif &filetype == 'html'
        exec ":AsyncRun chrome % &"
    elseif &filetype == 'go'
        exec "go Run  %"
    elseif &filetype == 'mkd'
        exec ":AsyncRun ~/.vim/markdown.pl % > %.html &"
        exec ":AsyncRun chrome %.html &"
    endif
endfunc


"func! QuickRun()
    "exec "w"
    "if &filetype == 'c'
        "exec "!gcc-9 % -fopenmp -o /tmp/%< && /tmp/%<"
    "elseif &filetype == 'cpp'
        ""exec "!make"
        "exec "!g++-9 % -o /tmp/a.out --std=c++11 -fopenmp && /tmp/a.out"
    "elseif &filetype == 'java'
        "exec "!javac %"
        ""elseif &filetype == 'sh'
        "":!time bash %
    "elseif &filetype == 'python'
        "exec "!python %"
    "elseif &filetype == 'html'
        "exec "!chrome % &"
    "elseif &filetype == 'go'
        "exec "go run %"
    "elseif &filetype == 'mkd'
        "exec "!~/.vim/markdown.pl % > %.html &"
        "exec "!chrome %.html &"
    "endif
"endfunc

function! GetUrl()
    silent !python ~/.vim/my_scripts/get_url.py
    silent redraw!
    normal "+p
endfunction

map <leader><leader>p :call GetUrl()<cr>
map <leader>p "+p

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
let g:table_mode_auto_align = 0
"let g:table_mode_delete_column_map = '<Leader>tdc'
" 光标移动到已经存在的表格上 :TableFormat，可以格式化已经存在的表格。
"}}}
"
"
"
"{{{ vim-auto-save
" let g:auto_save = 1
"}}}
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
    autocmd Filetype tex setl updatetime=1
    let g:livepreview_previewer = 'open -a skim'
    let g:livepreview_engine = 'xelatex --shell-escape'

    " 使grep总是生成文件名
    set grepprg=grep\ -nH\ $*
    " vim默认把空的tex文件设为plaintex而不是tex，导致latex-suite不被加载
    let g:tex_flavor='latex'
    set iskeyword+=:
    let g:Tex_CompileRule_pdf='xelatex --shell-escape -interaction=nonstopmode $*'
    let g:Imap_FreezeImap = 1
"}}}
"
"
"{{{ UltiSnips
    ""let g:UltiSnipsExpandTrigger="<c-j>"
    """ 使用 tab 切换下一个触发点，shit+tab 上一个触发点
    ""let g:UltiSnipsJumpForwardTrigger="<c-j>"
    ""let g:UltiSnipsJumpBackwardTrigger="<c-k>"

    "let g:UltiSnipsExpandTrigger="<tab>"
    "" 使用 tab 切换下一个触发点，shift+tab 上一个触发点
    "let g:UltiSnipsJumpForwardTrigger="<tab>"
    "let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

    "let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/plugins/vim-snippets/UltiSnips"]
    "" If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"
"}}}

" {{{
    let g:bookmark_highlight_lines  = 1
    let g:bookmark_no_default_key_mappings = 1
" }}}
"
" {{{ tagbar
    let g:tagbar_ctags_bin = "/usr/local/Cellar/ctags/5.8_1/bin/ctags"

    autocmd FileType c,cpp,py,markdown nested :TagbarOpen

    nnoremap tag :TagbarOpen fj<CR>
    "let g:tagbar_left = 1
    let g:tagbar_width = 20

    let g:tagbar_type_markdown = {
                \ 'ctagstype' : 'markdown',
                \ 'kinds' : [
                \ 'h:headings',
                \ ],
                \ 'sort': 0
                \ }
" }}}
"
" {{{ vim-markdown
    let g:vim_markdown_conceal_code_blocks = 0
" }}}
"
"" {{{ YouCompleteMe
    ""let g:ycm_global_ycm_extra_conf = '~/.vim/plugins/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
    "" 跳转到定义处
    "nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> 

    ""set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
    ""autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
    ""inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
    """上下左右键的行为 会显示其他信息
    ""inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    ""inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    ""inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
    ""inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

    ""在注释输入中也能补全
    "let g:ycm_complete_in_comments = 1
    ""在字符串输入中也能补全
    "let g:ycm_complete_in_strings = 1
    ""注释和字符串中的文字也会被收入补全
    "let g:ycm_collect_identifiers_from_comments_and_strings = 1

    "function! g:UltiSnips_Complete()
      "call UltiSnips#ExpandSnippet()
      "if g:ulti_expand_res == 0
        "if pumvisible()
          "return "\<C-n>"
        "else
          "call UltiSnips#JumpForwards()
          "if g:ulti_jump_forwards_res == 0
            "return "\<TAB>"
          "endif
        "endif
      "endif
      "return ""
    "endfunction

    "function! g:UltiSnips_Reverse()
      "call UltiSnips#JumpBackwards()
      "if g:ulti_jump_backwards_res == 0
        "return "\<C-P>"
      "endif

      "return ""
    "endfunction


    "if !exists("g:UltiSnipsJumpForwardTrigger")
      "let g:UltiSnipsJumpForwardTrigger = "<tab>"
    "endif
    "if !exists("g:UltiSnipsJumpBackwardTrigger")
      "let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    "endif

    "au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
    "au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
"" }}}
"
" {{{ auto-format
    au BufWrite *.cpp :Autoformat
    "let g:formatdef_mycustom = '"clang-format -style=\"{BasedOnStyle: llvm, IntentWidth: 4, BreakBeforeBraces: Allman}\""' 
    let g:formatdef_mycustom = '"astyle --style=ansi --keep-one-line-blocks --pad-oper"' 
    let g:formatters_cpp = ['mycustom']
" }}}
