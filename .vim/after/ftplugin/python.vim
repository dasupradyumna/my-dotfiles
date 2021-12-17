""" Python filetype configuration



" Save file format
setlocal fileformat=unix

" Enable syntax highlighting
let g:python_highlight_all = 1

" Indent options
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=4
setlocal textwidth=80

" SimpylFold mapping fold toggle
nnoremap <Space> za

" Virtual environment for python used in plugins
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ :
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

