let g:ale_fixers = {
\   'ruby': ['rubocop'],
\ }
" fixers に設定されたコマンドを bundle exec 経由で実行する
let g:ale_ruby_rubocop_executable = 'bundle'
