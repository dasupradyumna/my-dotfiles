" Lightline configuration file



set noshowmode                 " Do not display current Vim mode

" fugitive = Git
" gitcommit = Git commit
" git = Git log, Git diff, Git branch
" fugitiveblame = Git blame
" qf = Gclog, Git mergetool, Git difftool, Syntastic loc_list
let s:filetypemap = {
\   'fugitive': 'FUGITIVE',
\   'fugitiveblame': 'BLAME',
\   'git': 'FUGITIVE',
\   'gitcommit': 'COMMIT',
\   'qf': 'INFO',
\   'nerdtree': 'NERDTREE',
\   'vim-plug': 'VIM PLUG',
\ }

" Fix lightline not loading correctly on startup
autocmd VimEnter * call lightline#update()

" Helper function for Mode component functions
function! Mode(active)
  if a:active == 1
    return get(s:filetypemap, &filetype, lightline#mode())
  else
    return get(s:filetypemap, &filetype, '')
  endif
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
  if has_key(s:filetypemap, &filetype)
    return ''
  endif

  let readonly = (a:fullpath == 1) ? '' : (&readonly ? '[ro] ' : '')
  let filepath = (a:fullpath == 1) ? expand('%:p') : expand('%:t')
  let filename = filepath !=# '' ? filepath : '[Unnamed]'
  let modified = &modified ? ' +' : ''
  return readonly . filename . modified
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
  if winwidth(0) <= 70 || has_key(s:filetypemap, &filetype)
    return ''
  else
    return printf('%-1d,%-1d:%-1d', line('.'), col('.'), line('$'))
  endif
endfunction

" Component function for HEAD of current Git repository (if any)
function! Branchhead()
  if winwidth(0) <= 70 || has_key(s:filetypemap, &filetype)
    return ''
  endif
  return exists('*fugitive#head') ? fugitive#head : ''
endfunction

" Component function for file type
function! Filetype()
  if winwidth(0) <= 70 " || has_key(s:filetypemap, &filetype)
    return ''
  else
    return &filetype
  endif
endfunction

" Main dictionary with all the configurations
let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\     'left': [ [ 'amode' ], [ 'filename' ] ],
\     'right': [ [ 'lineinfo' ], [ 'head' ], [ 'filetype' ] ]
\   },
\   'inactive': {
\     'left': [ [ 'iamode' ], [ 'fullpath' ] ],
\     'right': [ ]
\   },
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


