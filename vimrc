call pathogen#helptags()
call pathogen#runtime_append_all_bundles() 

let g:Powerline_symbols = 'fancy'

set nocompatible
set laststatus=2
set encoding=utf-8
set colorcolumn=120
set cursorline
set scrolloff=5                 " keep at least 5 lines around the cursor
set nobackup

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " incremental searching
set ignorecase                      " searches are case insensitive...
set smartcase                       " ... unless they contain at least one capital letter

" Disable bells
set noerrorbells
set visualbell
set t_vb=
set showmatch

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" colorscheme stacy

highlight CursorLine term=none cterm=none ctermbg=234
highlight ColorColumn ctermbg=234
filetype indent on
filetype on

" Make cursor behave as expected with wrapped lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Clear search highlighting
"nnoremap <esc> :noh<return><esc>

" Fast saving
nmap <leader>w :w!<cr>

set wildmenu
set wildmode=list:longest,full

"if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a{ :Tabularize /{<CR>
  vmap <Leader>a{ :Tabularize /{<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
"endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"" 2 - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
let g:ctrlp_working_path_mode = 2
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

set wildignore+=*/.git/*,*.class

set runtimepath^=~/.vim/bundle/ctrlp.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
" Taken from https://github.com/garybernhardt/dotfiles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
 
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
nmap <F3> :NumbersToggle<CR>        " mapping f3 to NumbersToggle
