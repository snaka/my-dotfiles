let g:lsp_log_file = expand('~/.local/share/vim-lsp.log')

" reference のハイライト (効かない?)
" highlight lspReference ctermfg=red ctermbg=green

function! s:on_lsp_buffer_enabled() abort
  " 診断のサインを表示
  setlocal signcolumn=yes
  " キーマッピング
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gg <plug>(lsp-signature-help)
  nmap <buffer> gm <plug>(lsp-document-symbol)
  nmap <buffer> gw <plug>(lsp-workspace-symbol)
  nmap <buffer> gn <plug>(lsp-rename)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  " バッファを書き出す前にフォーマットする
  "   エラー出て動かない
  " autocmd BufWritePre <buffer> LspDocumentFormatSync
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
