"
"-------------------
"タブ・インデントの設定
" -------------------

set tabstop=4
set shiftwidth=4
"タブの代わりにスペースで埋める場合コメントはずす
"set softtabstop=4
"set expandtab
set backup
set backupdir=~/.backup/vim
set autoindent

set visualbell
" -------------------
" 色の設定
" -------------------
syntax on

highlight LineNr ctermfg=darkyellow " 行番号
highlight NonText ctermfg=darkgrey
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

set showmatch
set number

" -------------------
" 日本語の設定
" -------------------
"set termencoding=utf-8
"set encoding=japan
"set fenc=utf-8
"set enc=utf-8
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがJISX0213に対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^euc-\%(jp\|jisx0213\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            let &encoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    " 定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
endif

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" -------------------
" 検索
" -------------------
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"set hlsearch
set incsearch
" -------------------
" ファイルタイプ
" -------------------
au FileType perl call PerlType()
filetype plugin indent on
autocmd! BufRead,BufNewFile *.php set filetype=php
autocmd! BufRead,BufNewFile *.inc set filetype=php
autocmd! BufRead,BufNewFile *.cgi set filetype=perl
autocmd! BufRead,BufNewFile *.pass setlocal nobackup
autocmd! BufRead,BufNewFile *.html set filetype=html
autocmd! BufRead,BufNewFile *.java set filetype=java
autocmd! BufRead,BufNewFile *.m set filetype=objc
autocmd! BufRead,BufNewFile *.h set filetype=objc

" -------------------
set updatetime=500
" -------------------
" バッファ関連
" -------------------
set hidden " 切り替え時のundoの効果持続等
" -------------------
" その他
" -------------------
set notitle
set autowrite
set scrolloff=5 " スクロール時の余白確保
set history=50
set list
"set listchars=tab:\ \ ,extends:<,trail:\
set listchars=tab:\ \ ,extends:<,trail:\ 
set laststatus=2
set wildmode=full:list
"ommni -> Tab
function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    elseif exists('&omnifunc') && &omnifunc == ''
        return "\<c-n>"
    else
        return "\<c-x>\<c-o>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function PerlType()
    " FOLD の設定
    syn region myFold start="^sub" end="^}"he=e-1  keepend transparent fold
    syn sync fromstart
    set foldmethod=syntax
    set foldnestmax=3
    set fdn=1
endfunction

