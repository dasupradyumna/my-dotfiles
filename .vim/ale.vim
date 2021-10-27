" ALE configuration file



augroup ALE
  autocmd!
  " Open location list where detected errors are populated
  autocmd User ALELintPost
  \   lopen |
  \   wincmd p |
  \   call lightline#update() |
augroup END

" Use only the linters specified in the options
let g:ale_linters_explicit = 1

" List of linters to use
let g:ale_linters = {
\   'python': [ 'bandit', 'flake8' ]
\ }

" Appearance of signs in the gutter
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" List of fixers/formatters to use
let g:ale_fixers = {
\   'python': [ 'black', 'isort']
\ }

" Run file through fixer on saving it
let g:ale_fix_on_save = 1

" Let YCM handle the autocompletion
let g:ale_completion_enabled = 0

" Error/warning message display format
let g:ale_echo_msg_format = '[%linter%] %code% : %s [%severity%]'

