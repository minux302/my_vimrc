" read with utf-8
set encoding=utf-8
" setting for multi byte
scriptencoding utf-8

"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
if has('vim_starting')
    " setting untimepath to NeoBundle PATH only at first time
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " install NeoBundle
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

" NeoBundle plugin list
"-------------------------------
call neobundle#begin(expand('~/.vim/bundle/'))

" NeoBundle management plugin
NeoBundleFetch 'Shougo/neobundle.vim'
" Color Scheme
NeoBundle 'tomasr/molokai'
" visualize indent
NeoBundle 'Yggdroot/indentLine'
" visualize unnecessary soace
NeoBundle 'bronson/vim-trailing-whitespace'
" syntax checker
NeoBundle 'scrooloose/syntastic'

if has('lua')
     " auto completation
     NeoBundle 'Shougo/neocomplete.vim'
     " snippet function
     NeoBundle 'Shougo/neosnippet'
     " sinippets
     NeoBundle 'Shougo/neosnippet-snippets'
endif

call neobundle#end()
"-------------------------------

" enable vim plugin, indent for file type
filetype plugin indent on

" ask about uninstalled plugin
NeoBundleCheck


"----------------------------------------------------------
" setting for Color Scheme
"----------------------------------------------------------
if neobundle#is_installed('molokai')
    colorscheme molokai
endif

set t_Co=256
syntax enable


"----------------------------------------------------------
" setting for neocomplete, neosnippet
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " enable eocompletation
    let g:neocomplete#enable_at_startup = 1
    " utilize smartcase
    let g:neocomplete#enable_smart_case = 1
    " enable completation from n length charcter
    let g:neocomplete#min_keyword_length = 3
    " complete to delimiter
    let g:neocomplete#enable_auto_delimiter = 1
    " visualize popup by n charcter
    let g:neocomplete#auto_completion_start_length = 1
    " close popup by BS
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " setting for enter key
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " setting for tab key
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif


"----------------------------------------------------------
" setting for syntastic
"----------------------------------------------------------
" display '>>' for error line
let g:syntastic_enable_signs = 1
" prevent conflicts with other plugins"
let g:syntastic_always_populate_loc_list = 1
" hidden error lists
let g:syntastic_auto_loc_list = 0
" check when file is opened
let g:syntastic_check_on_open = 1
" check also when use ':wq'
let g:syntastic_check_on_wq = 1


"----------------------------------------------------------
" Code Charcter
"----------------------------------------------------------
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double


"----------------------------------------------------------
" Search
"----------------------------------------------------------
set incsearch
set ignorecase
set smartcase
set hlsearch


"----------------------------------------------------------
" tab, indent
"----------------------------------------------------------
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2

" overwrite setting for file types
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


"----------------------------------------------------------
" Cursol
"----------------------------------------------------------
set whichwrap=b,s,h,l,<,>,[,],~ " enable to move from end of line to start of next line
set number
set cursorline
set showmatch " visualise corresponding brackets

" enable to move folded line
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk


"----------------------------------------------------------
" otherwise
"----------------------------------------------------------
" enable BS
set backspace=indent,eol,start


" adjust indent for Paste
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

