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

Plug 'airblade/vim-gitgutter'     " Git line changes beside numbers column

Plug 'vim-syntastic/syntastic'    " Syntax checker plugin

" Plug 'preservim/nerdtree'         " File system tree explorer

call plug#end()



"""""" GENERAL
source ~/.vim/general.vim


"""""" GITGUTTER
source ~/.vim/gitgutter.vim


"""""" NERDTREE
" source ~/.vim/nerdtree.vim


"""""" SYNTASTIC
source ~/.vim/syntastic.vim


"""""" LIGHTLINE
source ~/.vim/lightline.vim


