" Vim startup configuration file [ User level ]



""""""  PLUGINS

" Automatic installation of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute
    \ '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs' .
    \ ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Vim Plug manager : plugins list
call plug#begin('~/.vim/plug')

Plug 'junegunn/vim-plug'          " Vim-Plug Documentation in `:help`

Plug 'bluz71/vim-moonfly-colors'  " Moonfly colorscheme

Plug 'itchyny/lightline.vim'      " Lightline configurable status

Plug 'tpope/vim-fugitive'         " Git plugin for vim

Plug 'airblade/vim-gitgutter'     " Git line changes in gutter column

Plug 'ycm-core/YouCompleteMe'     " General code completion and semantic comprehension engine

Plug 'dense-analysis/ale'         " Asynchronous Lint Engine, syntax checking

Plug 'tmhedberg/SimpylFold'       " Code folding for python

Plug 'Konfekt/FastFold'           " Speed up code folding in vim

" Plug 'preservim/nerdtree'         " File system tree explorer

call plug#end()



"""""" GENERAL
source ~/.vim/general.vim


"""""" NERDTREE
" source ~/.vim/nerdtree.vim


"""""" GITGUTTER
source ~/.vim/gitgutter.vim


"""""" ALE
source ~/.vim/ale.vim


"""""" YOUCOMPLETEME
source ~/.vim/ycm.vim


"""""" FOLDING
source ~/.vim/fold.vim


"""""" LIGHTLINE
source ~/.vim/lightline.vim


