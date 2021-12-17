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


augroup NetRWAuto
  autocmd!

  " Always open NetRW; but if file is opened, move focus to it
  " NetRW window always has fixed size ( width=30 )
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter *
  \   Vexplore |
  \   let s:netrw_winnr = winnr() |
  \   vertical resize 30 |
  \   set winfixwidth |
  \   set winfixheight |
  \   if argc() > 0 || exists('s:std_in') |
  \     wincmd p |
  \   endif

  " Close the tab if NetRW is the only window left
  autocmd BufEnter *
  \   if winnr('$') == 1 && bufname() ==# 'NetrwTreeListing' |
  \     quit |
  \   endif

  " Exit Vim if NetRW is the only window in the only tab
  autocmd BufEnter *
  \   if tabpagenr('$') == 1 && winnr('$') == 1 && bufname() ==# 'NetrwTreeListing' |
  \     quit |
  \   endif

augroup END

" function to toggle focus to and away from NetRW window
function! s:ToggleNetRWFocus()
  if winnr() != s:netrw_winnr
    let s:prev_winnr = winnr()
    execute s:netrw_winnr . 'wincmd w'
  else
    execute s:prev_winnr . 'wincmd w'
  endif
endfunction

nmap <C-n> :call <SID>ToggleNetRWFocus()<CR>
