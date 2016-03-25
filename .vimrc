call plug#begin()
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'bogado/file-line'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'elixir-lang/vim-elixir'
Plug 'airblade/vim-gitgutter'
Plug 'leshill/vim-json'
Plug 'plasticboy/vim-markdown'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'patrickdavey/vimwiki-1', { 'branch': 'dev' }
Plug 'mattn/calendar-vim'
call plug#end()
" install plugins with  :PlugInstall

" needed for vimwiki, also turns on filetype detection
filetype plugin on

"""""""""""""""""" SETTINGS """"""""""""""""""""
set nocompatible
syntax on
set hidden "Hidden" buffers -- i.e., don't require saving before editing another file.
set directory=$HOME/.vim/swapfiles// " store swapfiles locally

set ignorecase " don't worry about case when searching... unless smartcase - see below"
set smartcase " Use smart case, if we use an uppercase letter then it will match on case.

set encoding=utf-8
set pastetoggle=<F2>
set showmode

set history=1000 " big old history - needs to come after nocompatible
set relativenumber
set number
set cpoptions+=$

set formatoptions=qrn1

set splitbelow
set splitright

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showmatch "show matching parens
set ruler
set wildmenu "autocomplete the command line
set cursorline "show a line under the current line

set hlsearch "highlight searching
set incsearch "set incremental search"

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0
set backspace=indent,eol,start

" folding info
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
set clipboard=unnamed

""""""""""""""MAPPINGS"""""""""""""

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F4> :set nonumber! norelativenumber! <CR>
nnoremap <F3> :NERDTreeToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" The escape key is a long ways away. This maps it to the sequence 'kj'
map! kj <esc>

" get rid of the arrow keys, forces us to use hjkl as is only right and proper
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"faster navigation around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <CR> :noh<CR><CR>

" save the bugger
nnoremap <Leader>w :w<CR>

" removes newlines in my blogs!
nnoremap <Leader>b :%s/<\/a>[\n ]\{-}<a href/<\/a><a href/g<CR>

" send snippet to ruby for execution
vmap <leader>r <esc>:'<,'>:w !ruby<CR>
nmap <leader>r ggVG<esc>:'<,'>:w !ruby<CR>
vmap <leader>rr <esc>:'<,'> !ruby<CR>
nmap <leader>rr ggVG<esc>:'<,'> !ruby<CR>

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif

autocmd BufRead,BufNewFile .pryrc set filetype=ruby

augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END

au BufNewFile,BufRead *.ejs set filetype=html

"Syntastic on by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }

let g:vimwiki_list = [{'path': '~/vimwiki', 'template_path': '~/vimwiki/templates/',
          \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.md',
          \ 'path_html': '~/vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown',
          \ 'template_ext': '.tpl'},{'path': '~/secret_vimwiki', 'template_path': '~/vimwiki/templates/',
          \ 'template_default': 'default', 'syntax': 'markdown', 'ext': '.md',
          \ 'path_html': '~/secret_vimwiki/site_html/', 'custom_wiki2html': 'vimwiki_markdown',
          \ 'template_ext': '.tpl'}]

" start git in insert mode with spell check
if has('autocmd')
  if has('spell')
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    au BufNewFile,BufRead *.txt setlocal spell
  endif
  au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
endif

autocmd FileType vimwiki set spell spelllang=en_gb
"stolen from Gary Bernhart - open file at last position
"
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" |
  \ endif

if (system('uname') =~ "Darwin")
  colorscheme jellybeans
else
  colorscheme peachpuff
endif

let dialect='UK'
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,*.rabl,irb_tempfile*} set ft=ruby

fun! MarkExtraWhitespace(regex)
    " Only mark if the b:noMarkExtraWhitespace variable isn't set
    if exists('b:markdownWhitespace')
      highlight ExtraWhitespace ctermbg=LightCyan guibg=LightCyan
    else
      highlight ExtraWhitespace ctermbg=red guibg=red
    endif
    au ColorScheme * highlight ExtraWhitespace guibg=red
    execute 'match ExtraWhitespace ' . a:regex
endfun

autocmd FileType vimwiki,markdown let b:markdownWhitespace=1

au BufEnter * call MarkExtraWhitespace("/\\s\\s$/")
au InsertEnter * call MarkExtraWhitespace("/\\s\\+\\%#\\@<!$/")
au InsertLeave * call MarkExtraWhitespace("/\\s\\+$/")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Print full path to current File
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PrintFilePath()
  exec ":echo expand('%:p')"
endfunction

nnoremap <F5> :call PrintFilePath()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert hashes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ConvertHash()
  exec ':%s/:\([^ ]*\)\(\s*\)=>/\1:/g'
endfunction
map <leader>h :call ConvertHash()<cr>



"wrapping for gitgutter
function! GitGutterPrevHunkWrapping(count)
  let pre_line = line('.')
  exe a:count . 'GitGutterPrevHunk'
  let post_line = line('.')
  if (pre_line == post_line) && !empty(GitGutterGetHunks())
    normal! G
    call GitGutterPrevHunkWrapping(1)
  endif
endfunction
command -count=1 GitGutterPrevHunkWrapping call GitGutterPrevHunkWrapping(<count>)
nmap <silent> <expr> [c ":\<C-U>execute v:count1 . 'GitGutterPrevHunkWrapping'\<CR>"


"vim-rails customizations
let g:rails_projections = {
      \ "app/decorators/*_decorator.rb": {
      \   "command": "decorator",
      \   "template":
      \     "class %SDecorator < SimpleDelegator\nend",
      \   "test": [
      \     "test/unit/%s_decorator_test.rb",
      \     "spec/decorators/%s_decorator_spec.rb"
      \   ],
      \  "affinity": "model"
      \ },
      \ "app/presenters/*_presenter.rb": {
      \   "command": "presenter",
      \   "template":
      \     "class %SPresenter\nend",
      \   "test": [
      \     "test/unit/%s_presenter_test.rb",
      \     "spec/decorators/%s_presenter_spec.rb"
      \   ],
      \  "affinity": "view"
      \ }}

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" restrict ctrl-p to files in git, way faster
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

let g:vim_markdown_folding_disabled=1
let python_highlight_all = 1

" always show vim-airline
let g:airline_powerline_fonts=1
set laststatus=2


function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

"allow * and # to search using highlighted word in visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
vnoremap <leader>gg y:Ack <c-r>"<cr>

"tidy xml from
"http://ku1ik.com/2011/09/08/formatting-xml-in-vim-with-indent-command.html
au FileType xml setlocal equalprg=tidy\ -xml\ -i\ -w\ 0\ -q\ -\ 2>\/dev\/null\ \|\|\ true

autocmd FileType vimwiki nmap <Leader>c :Calendar <cr>
