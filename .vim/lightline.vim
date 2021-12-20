""" Lightline configuration file



set noshowmode                 " Do not display current Vim mode in command line

" fugitive = Git
" gitcommit = Git commit
" git = Git log, Git diff, Git branch
" fugitiveblame = Git blame
" qf = Gclog, Git mergetool, Git difftool
let s:filetypemap = {
\ 'fugitive': 'FUGITIVE',
\ 'fugitiveblame': 'BLAME',
\ 'git': 'FUGITIVE',
\ 'gitcommit': 'COMMIT',
\ 'qf': 'INFO',
\ 'nerdtree': 'NERDTREE',
\ 'netrw': 'FILES',
\ 'vim-plug': 'VIM PLUG',
\ }

" Helper function to check if current window is running a terminal
function! IsTerminal()
  return get(getwininfo(win_getid())[0], 'terminal')
endfunction

" Helper function to check if current window is not user-related
function! IsSpecialWindow()
  let l:splitfilename = split(expand('%:t'), '\.')
  return has_key(s:filetypemap, &filetype) ||
         \ IsTerminal() ||
         \ (len(l:splitfilename) != 0 && l:splitfilename[0] == 'vimspector') &&
         \ (&filetype == '' || &filetype == 'VimspectorPrompt')
endfunction

" Fix lightline not loading correctly on startup
autocmd VimEnter,WinEnter,CursorHold * call lightline#update()

" Helper function for Mode component functions
function! Mode(active)
  let l:splitfilename = split(expand('%:t'), '\.')
  let l:defaultvalue = IsTerminal()
                     \ ? 'TERMINAL'
                     \ : (len(l:splitfilename) != 0 && l:splitfilename[0] == 'vimspector') &&
                     \   (&filetype == '' || &filetype == 'VimspectorPrompt')
                     \   ? l:splitfilename[1]
                     \   : a:active == 1
                     \     ? lightline#mode()
                     \     : ''
  return get(s:filetypemap, &filetype, l:defaultvalue)
endfunction

" Component function for active mode
function! AMode()
  return Mode(1)
endfunction

" Component function for inactive mode
function! IAMode()
  return Mode(0)
endfunction

" Helper function for Filename component functions
function! Filepath(fullpath)
  if IsSpecialWindow()
    return ''
  endif

  let readonly = a:fullpath == 1 ? '' : &readonly ? '[ro] ' : ''
  let filepath = a:fullpath == 1 ? expand('%:p') : expand('%:t')
  let filename = filepath !=# '' ? filepath : '[Unnamed]'
  let modified = &modified ? '* ' : ''
  return readonly . modified . filename
endfunction

" Component function for current file name
function! Filename()
  return Filepath(0)
endfunction

" Component function for full path of current file
function! Fullpath()
  return Filepath(1)
endfunction

" Component function for cursor position in file
function! Lineinfo()
  if winwidth(0) <= 70 || IsSpecialWindow()
    return ''
  else
    return printf('%-1d,%-1d:%-1d', line('.'), col('.'), line('$'))
  endif
endfunction

" Component function for HEAD of current Git repository (if any)
function! BranchHead()
  if winwidth(0) <= 70 || IsSpecialWindow()
    return ''
  endif
  return exists('*FugitiveHead') ? '⌥ ' . FugitiveHead() : ''
endfunction

" Component function for file type
function! Filetype()
  if winwidth(0) <= 70 || IsSpecialWindow()
    return ''
  else
    return &filetype
  endif
endfunction

" ALE Indicator symbols to print beside count values
let s:indicators = {
\ 'error': '᙭ ',
\ 'info': 'ⓘ ',
\ 'warning': ' ⃠ ',
\ }

" Helper function for ALE indicator functions
function! AleStatuslineCount(type)
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:count_val = a:type == 'error'
                  \ ? printf('%d,%d',
                  \     get(l:counts, 'error', 0),
                  \     get(l:counts, 'style_error', 0))
                  \ : string(get(l:counts, a:type, 0))
  return l:count_val == '0' || l:count_val == '0,0'
  \ ? '' : printf('%s%s', get(s:indicators, a:type), l:count_val)
endfunction

" Error count
function! AleErrorCount()
  return AleStatuslineCount('error')
endfunction

" Warning count
function! AleWarningCount()
  return AleStatuslineCount('warning')
endfunction

" Info count
function! AleInfoCount()
  return AleStatuslineCount('info')
endfunction


" Main dictionary with all the configurations
let g:lightline = {
\   'colorscheme': 'one',
\
\   'active': {
\     'left': [ [ 'amode' ], [ 'filename' ] ],
\     'right': [ [ 'lineinfo' ], [ 'head' ],
\                [ 'aleerr', 'alewarn', 'aleinfo' ],
\                [ 'filetype' ] ]
\   },
\
\   'inactive': {
\     'left': [ [ 'iamode' ], [ 'fullpath' ] ],
\     'right': [ ]
\   },
\
\   'component_type': {
\     'aleinfo': 'info',
\     'alewarn': 'warning',
\     'aleerr': 'error',
\   },
\
\   'component_expand': {
\     'aleinfo': 'AleInfoCount',
\     'alewarn': 'AleWarningCount',
\     'aleerr': 'AleErrorCount',
\   },
\
\   'component_function': {
\     'amode': 'AMode',
\     'iamode': 'IAMode',
\     'filename': 'Filename',
\     'lineinfo': 'Lineinfo',
\     'head': 'BranchHead',
\     'filetype': 'Filetype',
\     'fullpath': 'Fullpath',
\   },
\ }


