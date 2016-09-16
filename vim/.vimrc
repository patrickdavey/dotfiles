" vim:foldmethod=marker
" Plugins {{{"
call plug#begin()
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'bogado/file-line'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-ruby/vim-ruby'
Plug 'mustache/vim-mustache-handlebars'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'elixir-lang/vim-elixir'
Plug 'airblade/vim-gitgutter'
Plug 'leshill/vim-json'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'patrickdavey/vimwiki-1', { 'branch': 'dev' }
Plug 'mattn/calendar-vim'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-startify'
Plug 'posva/vim-vue'
Plug 'justinmk/vim-sneak'

call plug#end()

" install plugins with  :PlugInstall
" }}}
" {{{ Settings
filetype plugin on

set background=dark
colorscheme jellybeans
set nocompatible
syntax on
set hidden "Hidden" buffers -- i.e., don't require saving before editing another file.
set directory=$HOME/.vim/swapfiles// " store swapfiles locally
let python_highlight_all = 1
runtime macros/matchit.vim

set ignorecase " don't worry about case when searching... unless smartcase - see below"
set smartcase " Use smart case, if we use an uppercase letter then it will match on case.

set encoding=utf-8
set pastetoggle=<F2>
set showmode
set showcmd "show the partial command in the bottom RHS"

set history=1000 " big old history - needs to come after nocompatible
set relativenumber
set number
set cpoptions+=$

set formatoptions=qrn1

set splitbelow
set splitright
set diffopt=vertical
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

set clipboard=unnamed
set linebreak "wrap lines with full words.
set regexpengine=1 "use the old regex engine, mainly for ruby syntax issue

let dialect='UK'

set iskeyword+=- "make a - be considered part of a word"

"set lazyredraw " Don't redraw screen when running macros.
"}}}
" {{{ Mappings
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F4> :set nonumber! norelativenumber! <CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" The escape key is a long ways away. This maps it to the sequence 'kj'
noremap! kj <esc>
set t_ut=

"make space toggle folds
nnoremap <space> za

"faster navigation around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Tab>   :bnext<CR>
nnoremap <S-Tab>   :bprevious<CR>
" Next two mappings from Gary Bernhart
" make %% in command mode to be the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>

command! Q q " Bind :Q to :q
" make <cr> clear highlight search
nnoremap <CR> :nohlsearch<CR><CR>
" }}}
" {{{ Leader Settings & Mappings
let mapleader = ","

" write the current file
nnoremap <Leader>w :w<CR>

" used for my blog, remove extra newlines
nnoremap <Leader>b :%s/<\/a>[\n ]\{-}<a href/<\/a><a href/g<CR>

" ruby mappings, run / replace current file / range with executed ruby code
vnoremap <leader>r <esc>:'<,'>:w !ruby<CR>
nnoremap <leader>r ggVG<esc>:'<,'>:w !ruby<CR>
vnoremap <leader>rr <esc>:'<,'> !ruby<CR>
nnoremap <leader>rr ggVG<esc>:'<,'> !ruby<CR>

vnoremap <leader>gh <esc>:'<,'> !pandoc -f markdown_github -w html5<CR>
nnoremap <leader>gh ggVG<esc>:'<,'>  !pandoc -f markdown_github -w html5<CR>
" shortcuts to editing the vimrc
nnoremap <leader>ev :edit ~/dotfiles/vim/.vimrc<cr>
nnoremap <leader>sv :source ~/dotfiles/vim/.vimrc<cr>

" make leader e append the current files directory to the path
noremap <leader>e :edit %%

" make <leader>, jump to the alternate file
nnoremap <leader>, <C-^>

" leader gg acks for the given text.
vnoremap <leader>gg y:Ack "<c-r>""<cr>

" complete the longest line. Supertab should have an alternative methinks
inoremap <leader>l <C-X><C-L>
nnoremap <leader>f :CtrlP<CR>

" }}}
" {{{ Folding settings & sneakiness
set foldmethod=syntax "possibly should be manual
set foldnestmax=5
set foldlevelstart=10
set foldenable
augroup view_making_for_folds
  autocmd!
  autocmd BufWrite {*.md,*.rb,.vimrc} mkview
  autocmd BufNewFile,BufRead {*.md,*.rb,.vimrc} silent loadview
augroup END

"}}}
" {{{ Startify Start screen customization
let g:startify_custom_header = [] "turn off random quote
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header =
    \ map(readfile(glob('~/vimwiki/commands_to_learn.md'), '', 10), 'repeat(" ", 8) . v:val')
let g:startify_bookmarks = [ {'o': '~/secret_vimwiki/index.md'} ]

" }}}
" {{{ Drupal autocmd
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd!
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif
" }}}
" {{{ Rubyish autocommands
autocmd BufRead,BufNewFile .pryrc set filetype=ruby
autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,*.rabl,irb_tempfile*} set ft=ruby
" }}}
" {{{ Git autocmd settings
" start git in insert mode with spell check
if has('autocmd')
  if has('spell')
    au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    au BufNewFile,BufRead *.txt setlocal spell
  endif
  au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
endif
" }}}
" {{{ JSON autocmd
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END
" }}}
" {{{ augroup for xml indenting
"tidy xml from
"http://ku1ik.com/2011/09/08/formatting-xml-in-vim-with-indent-command.html
au FileType xml setlocal equalprg=tidy\ -xml\ -i\ -w\ 0\ -q\ -\ 2>\/dev\/null\ \|\|\ true
" }}}
" {{{ Syntastic plugin settings
"Syntastic on by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html', 'sass', 'scss'] }
" }}}
" {{{ Vimwiki plugin settings and specific functions: "
"
function! OpenSecretCalendar()
  call vimwiki#base#goto_index(2)
  execute ':Calendar'
endfunction
nnoremap <leader>c :call OpenSecretCalendar()<cr>

let g:vimwiki_folding='expr' "this allows the folding to work for markdown

let g:vimwiki_list = [{
          \ 'path': '~/vimwiki',
          \ 'template_path': '~/vimwiki/templates/',
          \ 'nested_syntaxes': {
          \   'ruby': 'ruby',
          \   'elixir': 'elixir',
          \   'javascript': 'javascript',
          \   'bash': 'sh'
          \  },
          \ 'template_default': 'default',
          \ 'syntax': 'markdown',
          \ 'ext': '.md',
          \ 'path_html': '~/vimwiki/site_html/',
          \ 'custom_wiki2html': 'vimwiki_markdown',
          \ 'template_ext': '.tpl'
          \ },
          \ {
              \ 'path': '~/secret_vimwiki',
              \ 'template_path': '~/vimwiki/templates/',
              \ 'template_default': 'default',
              \ 'syntax': 'markdown',
              \ 'ext': '.md',
              \ 'path_html': '~/secret_vimwiki/site_html/',
              \ 'custom_wiki2html': 'vimwiki_markdown',
              \ 'template_ext': '.tpl'
              \  }]

autocmd FileType vimwiki set spell spelllang=en_gb
" }}}
" {{{ autocmd to open file at last position
"stolen from Gary Bernhart - open file at last position
"
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" |
  \ endif
" }}}
" {{{ function for marking extra whitespace (conditionally)

au! ColorScheme ExtraWhitespace ctermbg=red

fun! MarkExtraWhitespace(regex)
    " Only mark if the g:noMarkExtraWhitespace variable isn't set
    if exists('g:calendarWhitespace')
      highlight ExtraWhitespace ctermbg=None
    elseif exists('g:markdownWhitespace')
      highlight ExtraWhitespace ctermbg=LightCyan
    else
      highlight ExtraWhitespace ctermbg=red
    endif

    execute 'match ExtraWhitespace ' . a:regex
endfun

autocmd FileType vimwiki,markdown let g:markdownWhitespace=1
autocmd FileType calendar let g:calendarWhitespace=1
autocmd User Startified highlight ExtraWhitespace ctermbg=None

au BufEnter * call MarkExtraWhitespace("/\\s\\s$/")
au InsertEnter * call MarkExtraWhitespace("/\\s\\+\\%#\\@<!$/")
au InsertLeave * call MarkExtraWhitespace("/\\s\\+$/")


" }}}
" {{{ function to rename current file

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
noremap <leader>n :call RenameFile()<cr>
" }}}
" {{{ function : prinf full path to current file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Print full path to current File
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PrintFilePath()
  exec ":echo expand('%:p')"
endfunction

nnoremap <F5> :call PrintFilePath()<CR>
" }}}
" {{{ function to convert ruby 1.8.7 to 1.9 hashes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert hashes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ConvertHash()
  exec ':%s/:\([^ ]*\)\(\s*\)=>/\1:/g'
endfunction
noremap <leader>h :call ConvertHash()<cr>
" }}}
" {{{ gitgutter wrapping allows you to wrap changes with [c

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
command! -count=1 GitGutterPrevHunkWrapping call GitGutterPrevHunkWrapping(<count>)
noremap <silent> <expr> [c ":\<C-U>execute v:count1 . 'GitGutterPrevHunkWrapping'\<CR>"
" }}}
" {{{ vim-rails customizations
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
" }}}
" {{{ ctrl-p - only look for files in git
" restrict ctrl-p to files in git, way faster
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }
" }}}
" {{{ vim-airline settings
" always show vim-airline
let g:airline_powerline_fonts=1
set laststatus=2
" }}}
" {{{ function to allow searching with highlighted word
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

"allow * and # to search using highlighted word in visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
" }}}
" {{{ colorscheme fix for spelling errors with jellybeans
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=blue
hi clear SpellLocal
hi SpellLocal cterm=underline ctermfg=blue
hi clear SpellRare
hi SpellRare cterm=underline ctermfg=blue
" }}}
" {{{ PHP Augroup
augroup php_autocmd
  autocmd!
  autocmd FileType php set suffixesadd+=.php
augroup END
" }}}
