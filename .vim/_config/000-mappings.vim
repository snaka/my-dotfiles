"
" キーマッピング
"

" タブ関係
map <C-t>c :tabnew<CR>
map <C-t>C :$tabnew<CR>
map <C-t>o :tabonly<CR>
map <C-t>q :tabclose<CR>
map <C-n> :tabnext<CR>
map <C-p> :tabprev<CR>

" insert mode
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <silent> jj <ESC>

" VSCode
xmap gc <Plug>VSCodeCommentary
nmap gc <Plug>VSCodeCommentary
omap gc <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

