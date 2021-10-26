" NerdTree configuration file



let NERDTreeShowHidden = 1

" Key mappings
nnoremap <C-n> :NERDTreeFocus<CR>

" Always start NERDTree. But if a file is opened, move the cursor to it
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter *
\   NERDTree |
\   if argc() > 0 || exists('s:std_in') |
\     wincmd p |
\   endif

" Open existing NERDTree in each new tab
autocmd BufWinEnter *
\   if getcmdwintype() == '' |
\     silent NERDTreeMirror |
\   endif

" Close the tab if NERDTree is the only window remaining
autocmd BufEnter *
\   if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
\     quit |
\   endif

" Exit vim if NERDTree is the only window in the last tab
autocmd BufEnter *
\   if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
\     quit |
\   endif

" Fix NERDTree window in its default position
autocmd BufEnter *
\   if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
\     let buf = bufnr() |
\     buffer# |
\     execute 'normal! \<C-W>w' |
\     execute 'buffer'.buf |
\   endif

