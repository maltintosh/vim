scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される 
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される  
set ambiwidth=double " □や○文字が崩れる問題を解決
"タブ入力を複数の空白入力に置き換える
set tabstop=8 " 画面上でタブ文字が占める幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=8 " smartindentで増減する幅
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
set virtualedit=onemore "行末に移動できるようにする





"カスタムキーマッピング
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
".zshrc
"start insert mode
"alias vi ="vim -c 'startinsert'"
"
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

"esc変更
inoremap <silent> jj <C-o>:call Return()<cr>
function! Return()
	if col(".")==1
		silent call feedkeys("\<ESC>","n")
	else 
		silent call feedkeys("\<ESC>l","n")
	endif
endfunction

"leaderマッピング変更
let mapleader = "\<Space>"

"cat >> ~/.bashrc or .zshrc
"bind -r '\C-s' or bindkey -r '\C-s' 
"stty -ixon
nnoremap <C-s> :w<CR>
nnoremap <Leader>s :w<CR>
inoremap <silent> <C-s> <C-o>:w<CR>

nnoremap <Leader>q :q<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nmap <Leader>i I
nmap <Leader>v V

inoremap <S-C-z> <C-r>i

inoremap <C-d> <Del>
cnoremap <C-a> <Home>
inoremap <C-a> <Home>
" " 行末へ移動
cnoremap <C-e> <End>
inoremap <C-e> <End>

inoremap <silent> <C-c> <C-o>:call setreg("",getline("."))<CR>
vnoremap <C-c> yi

inoremap <C-v> <C-o>P

inoremap <C-x> <C-o>:call setreg("",getline("."))<CR><C-o>"_dd
vnoremap <C-x> xi 
inoremap <S-Tab> <C-d>

inoremap <C-z> <C-o>u
inoremap <C-y> <C-o><C-r>

" commentary.vim
vmap <C-_> gci
imap <C-_> <ESC>vgci


inoremap <C-u> <ESC>ld0i

imap <C-k> jj<ESC>:call Killend()<cr>
function! Killend()
    if col(".")==1
	    "normal <ESC><S-d>i
	    silent call feedkeys("\<S-d>i", "n")
    else
	    "inormal <ESC>l<S-d>i
	    silent call feedkeys("l\<S-d>i","n")
    endif
endfunction
"command! killend :killend()
" Exコマンドを実装する関数を定義
function! ExecExCommand(cmd)
    silent exec a:cmd
    return ''
endfunction
inoremap <silent> <expr> <C-p> "<C-r>=ExecExCommand('normal k')<CR>"
inoremap <silent> <expr> <C-n> "<C-r>=ExecExCommand('normal j')<CR>"

"補完せず補完ウィンドウを閉じてから移動
inoremap <silent> <expr> <C-b> "<C-r>=ExecExCommand('normal h')<CR>"
inoremap <silent> <expr> <C-f> "<C-r>=ExecExCommand('normal l')<CR>" 


""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch " 括弧の対応関係を一瞬表示する

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数
"マウス
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif
"ペースト設定
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

"neobundle
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/


    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②
" カラースキームmolokai
NeoBundle 'tomasr/molokai'
" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'neoclide/coc.nvim', 'release', { 'build': { 'others': 'git checkout release' } }
"----------------------------------------------------------
call neobundle#end()
" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck
"----------------------------------------------------------
" molokaiの設定
"----------------------------------------------------------
"
autocmd ColorScheme * highlight Comment ctermfg=102
autocmd ColorScheme * highlight Visual  ctermbg=225
colorscheme molokai " カラースキームにmolokaiを設定する

syntax enable " 構文に色を付ける

"----------------------------------------------------------
" ステータスラインの設定
"----------------------------------------------------------
set laststatus=2 " ステータスラインを常に表示
set showmode " 現在のモードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"------------------------------------------------------------
"" NERD-Tree.vim
"------------------------------------------------------------
"
"
" put this in your .vimrc
set wildignore+=*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let g:NERDTreeIgnore=['\.DS_Store$', '\.git$', '\.svn$', '\.clean$', '\.swp$', '\.bak$', '\.hg$', '\.hgcheck$', '\~$']

" Nerdtree config for wildignore
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :CD<CR>:NERDTree<CR>
let NERDTreeShowHidden=1

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
	    lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
	pwd
    endif
endfunction
