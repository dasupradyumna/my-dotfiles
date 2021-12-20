" NetRW configuration file



" Removing the banner at top of the window
let g:netrw_banner = 0

" Setting listing style to Tree view
let g:netrw_liststyle = 3

" How to open file from the NetRW
let g:netrw_browse_split = 4

" Exclude certain file types from NetRW
let g:netrw_list_hide = '.*\.swp$'
let g:netrw_hide = 1

" NetRW window number should always be 1, fixed position in any tab
let s:netrw_winnr = 1

augroup NetRWAuto
  autocmd!

  " Always open NetRW once in every tab
  " Move window focus to file if not blank
  " NetRW window always has fixed size and position
  autocmd BufEnter *
  \   if !gettabvar(tabpagenr(), 'NetrwIsOpen', 0) |
  \     call settabvar(tabpagenr(), 'NetrwIsOpen', 1) |
  \     let s:ActiveWin = empty(bufname()) ? 1 : 2 |
  \     execute '15 Lexplore ' . getcwd() |
  \     set winfixwidth |
  \     set winfixheight |
  \     execute s:ActiveWin . 'wincmd w' |
  \     if tabpagenr('$') > 1 | unlet s:ActiveWin | endif |
  \   elseif exists('s:ActiveWin') && &filetype ==# 'netrw' |
  \     execute s:ActiveWin . 'wincmd w' |
  \     unlet s:ActiveWin |
  \   endif

  " Close the tab if NetRW is the only window left
  autocmd BufEnter *
  \   if winnr('$') == 1 && &filetype ==# 'netrw' |
  \     quit |
  \   endif

  " Exit Vim if NetRW is the only window in the only tab
  autocmd BufEnter *
  \   if tabpagenr('$') == 1 && winnr('$') == 1 && &filetype ==# 'netrw' |
  \     quit |
  \   endif

augroup END

" function to toggle focus to and away from NetRW window
function! s:ToggleNetRWFocus()
  if winnr() != s:netrw_winnr
    let s:prev_winnr = winnr()
    execute s:netrw_winnr . 'wincmd w'
  else
    execute get(s:, 'prev_winnr', 2) . 'wincmd w'
  endif
endfunction

nmap <C-n> :call <SID>ToggleNetRWFocus()<CR>

" Quit all windows if 'quit' is used in Netrw window
command Q :if &filetype == 'netrw' | qa | else | q | endif
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Q' : 'q')<CR>
