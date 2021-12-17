" YouCompleteMe configuration file



" Closes the preview window after the completion is selected
let g:ycm_autoclose_preview_window_after_completion = 1

" Disable auto-preview of documentation of identfier under cursor
let g:ycm_auto_hover = ''

" Seed identifier database with programming language keywords
let g:ycm_seed_identifiers_with_syntax = 1

" To make sure that Syntastic and YCM work together for C-family
let g:ycm_show_diagnostics_ui = 0


" Key maps for easy usage

nnoremap <Leader>gt :YcmCompleter GoTo<CR>
nnoremap <Leader>gd :YcmCompleter GoToDefintion<CR>
nnoremap <Leader>gD :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>gT :YcmCompleter GetType<CR>
nnoremap <Leader>gR :YcmCompleter RefactorRename
