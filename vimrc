let g:pathogen_disabled = ['vim-powerline', 'vim-bufferline']
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

let g:EasyMotion_leader_key = '<Leader>'

let g:Powerline_symbols = 'fancy'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'

" Set a nicer foldtext function
let g:airline_theme             = 'powerlineish'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_check_on_open = 1

" vim-powerline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'

let g:gitgutter_highlight_lines = 1

set expandtab
set shiftwidth=2
set softtabstop=2

"set foldmethod=indent
"set foldlevelstart=-1
"set foldtext=MyFoldText()

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
autocmd BufWinEnter *.* match ExtraWhitespace /\s\+$/

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

autocmd ColorScheme * highlight SignColumn ctermbg=black
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" colorscheme stacy

highlight CursorLine term=none cterm=none ctermbg=234
highlight ColorColumn ctermbg=234

filetype plugin indent on

" Make cursor behave as expected with wrapped lines
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
set whichwrap+=<,>,h,l,[,]

" Clear search highlighting
"nnoremap <esc> :noh<return><esc>

" Fast saving
let mapleader=','
" nmap <leader>s :w!<cr>

" create hidden buffer when navigating away from unsaved changes
set hidden

map <silent> <leader><cr> :noh<cr>

" Move around windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move a line of text using Leader+[JK]
nmap <leader>J mz:m+<cr>`z
nmap <leader>K mz:m-2<cr>`z
vmap <leader>J :m'>+<cr>`<my`>mzgv`yo`z
vmap <leader>K :m'<-2<cr>`>my`<mzgv`yo`z

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

set wildmenu
set wildmode=list:longest,full

" align on various characters
for [shortcuts, padding] in [['=+*-/{}', '/l1l1'], ['([', '/l1l0'], [')]', '/l0l1'], [';:,', '\zs']]
  for s in split(shortcuts, '\zs')
    execute 'nmap <leader>a' . s . ' :Tabularize /' . s . padding . '<CR>'
    execute 'vmap <leader>a' . s . ' :Tabularize /' . s . padding . '<CR>'
  endfor
endfor

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"" 2 - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
let g:ctrlp_working_path_mode = 2
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_max_files=0

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
" Globally Replace word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<left><left>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
nmap <F3> :NumbersToggle<CR>        " mapping f3 to NumbersToggle

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
