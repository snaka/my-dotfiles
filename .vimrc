"

" syntaxハイライト有効
syntax enable

" fileencodings
set fileencodings=utf-8,cp932,sjis

" statusline行数
set laststatus=2

" カーソル下の単語をgrep
nnoremap <expr> gr ':grep '.expand('<cword>').' `git ls-files app` \|cw'

" 自動保存
set autowrite

function s:AutoWriteIfPossible()
  if &modified && !&readonly && bufname('%') !=# '' && &buftype ==# '' && expand('%') !=# ''
    write
  endif
endfunction

autocmd CursorHold  * call s:AutoWriteIfPossible()
autocmd CursorHoldI * call s:AutoWriteIfPossible()

" grep時にquickfix-windowを開く
autocmd QuickFixCmdPost *grep* cwindow

" オートインデント
set autoindent

" タブ関係
set expandtab
set shiftwidth=2
set tabstop=2

" バックスペースでinsertモードの前に入力した文字も消す
set backspace=2

" 行末のスペースを可視化
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

" 全てのモードでマウスを使用可能に
set mouse=a
set ttymouse=xterm2

" ctags 関連
set tags+=.tags;
set tags+=.gems.tags;

" NERDTree
map tt :NERDTreeToggle<CR>

"==============
" QFixHowm関連
"==============
set runtimepath+=~/.vim/plugins/qfixapp
let QFixHowm_Key = 'g'
"let QFixHowm_FileType = 'markdown'
"let howm_dir = '~/Documents/howm'
let howm_dir = '~/Dropbox/howm'
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'unix'
let QFixHowm_Folding = 0

" MRU表示数
let QFixHowm_MruFileMax = 100

" ,lコマンドのデフォルト検索期間
let QFixHowm_RecentDays = 200

" QuickFixからウィンドウを開いた後閉じる
"let QFix_CloseOnJump = 1

" 外部grepを使う
""set grepprg=grep\ -nH
set grepprg=ag\ -n\ -iS

"================
" NeoBundle
"================
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" Initialize
call neobundle#begin(expand('~/.vim/bundle/'))

" NoeBundle で NeoBundleを管理
NeoBundleFetch 'Shougo/neobundle.vim'

" originalrepos on github
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'othree/yajs.vim'
NeoBundle 'maxmellon/vim-jsx-pretty'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'lepture/vim-jinja'

call neobundle#end()

filetype plugin indent on     " required!
" filetype indent on

" 起動時にインストールチェック
NeoBundleCheck

"--- syntastic
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"--- colorscheme
colorscheme jellybeans

"================
" その他
" ================

" 折り畳み設定
set foldmethod=indent
"set foldcolumn=6
set foldlevel=99

" 行番号
set number

"
imap <leader>task { }
imap <leader>magic # -*- coding: utf-8 -*-<CR>
imap <leader>days  - xx/xx(月)<CR>- xx/xx(火)<CR>- xx/xx(水)<CR>- xx/xx(木)<CR>- xx/xx(金)<CR>

" CdCurrent
command! -nargs=0 CdCurrent cd %:p:h

" OpenCurrentFolder
command! -nargs=0 OpenCurrent e %:p:h

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" タブ関係
map <C-t>c :tabnew<CR>
map <C-t>o :tabonly<CR>
map <C-t>q :tabclose<CR>
map <C-n> :tabnext<CR>
map <C-p> :tabprev<CR>

" 保存
map <leader>s :update<CR>

" プロジェクト関係
cab seven ~/projects/seven/game_server
cab nine ~/projects/nine/game_server

" vimdiff の色設定
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

" クリップボードを有効に
"set clipboard=unnamed
" yank できなくなるのでコメントアウト

" javaソースコード用
autocmd FileType java setl ts=4

" ===========================
" pwerline
" ===========================
set t_Co=256
"set encoding=utf-8
"let g:Powerline_symbols='compatible'

" ===========================
" Insert mode map
" ===========================

" 引用符・カッコの自動挿入
"inoremap { {}<Left>
"inoremap [ []<Left>
"inoremap ( ()<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>

" カーソル移動
"inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
"inoremap <C-l> <Right>


" ===========================
" Mac vim
" ===========================
set guifont=Sauce\ Code\ Powerline:h11


" ===========================
" Rainbow parentheses.vim
" ===========================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare

