""" Gitgutter configuration file



" Icons for the signs column
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Automatically refresh gitgutter signs column
autocmd CursorHold * GitGutter
