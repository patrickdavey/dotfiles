" vim:foldmethod=marker
" Plugins {{{"
let mapleader = ","

call plug#begin()
Plug 'freitass/todo.txt-vim'
Plug 'mileszs/ack.vim'
Plug 'rodjek/vim-puppet'
Plug 'ervandew/supertab'
Plug 'bogado/file-line'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails', { 'commit': 'd8d8151a4f85686196524bed4950c59e37d2e8e9'}
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rhubarb'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-ruby/vim-ruby'
Plug 'mustache/vim-mustache-handlebars'
Plug 'godlygeek/tabular'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-signify'
Plug 'leshill/vim-json'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'mattn/calendar-vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify'
Plug 'posva/vim-vue'
Plug 'justinmk/vim-sneak'
Plug 'janko-m/vim-test'
Plug 'c-brenn/phoenix.vim'
Plug 'isRuslan/vim-es6'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'alvan/vim-closetag'
Plug 'pearofducks/ansible-vim'
let g:delimitMate_expand_cr = 2
call plug#end()


" install plugins with  :PlugInstall
" }}}
" {{{ Settings
filetype plugin on

set rtp+=/usr/local/opt/fzf

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
set wildmode=full
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

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"set lazyredraw " Don't redraw screen when running macros.
"}}}
" {{{ Mappings
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F4> :set nonumber! norelativenumber! <CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! w !sudo tee > /dev/null %

" The escape key is a long ways away. This maps it to the sequence 'kj'
noremap! kj <esc>

" quickly save in insert mode with jk
inoremap jk <esc>:w<cr>a

imap <c-x><c-l> <plug>(fzf-complete-line)
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
command! -nargs=1 PA args `=systemlist(<q-args>)`
" make <cr> clear highlight search
nnoremap <CR> :nohlsearch<CR><CR>

" }}}
" {{{ Leader Settings & Mappings

" write the current file
nnoremap <Leader>w :w<CR>
nnoremap <Leader>tt :e ~/Dropbox/todo/todo.txt<CR>

" used for my blog, remove extra newlines
nnoremap <Leader>b :%s/<\/a>[\n ]\{-}<a href/<\/a><a href/g<CR>

" ruby mappings, run / replace current file / range with executed ruby code
vnoremap <leader>r <esc>:'<,'>:w !ruby<CR>
nnoremap <leader>r ggVG<esc>:'<,'>:w !ruby<CR>
vnoremap <leader>rr <esc>:'<,'> !ruby<CR>
nnoremap <leader>rr ggVG<esc>:'<,'> !ruby<CR>

nnoremap <leader>json ggVG<esc>:'<,'>:!python -m json.tool<CR>

vnoremap <leader>gh <esc>:'<,'> !pandoc -f markdown_github -w html5<CR>
nnoremap <leader>gh ggVG<esc>:'<,'>  !pandoc -f markdown_github -w html5<CR>
nnoremap <leader>pdf :call ConvertMarkdownToPDF()<cr>

" shortcuts to editing the vimrc
nnoremap <leader>ev :edit ~/dotfiles/vim/.vimrc<cr>
nnoremap <leader>sv :source ~/dotfiles/vim/.vimrc<cr>

" make leader e append the current files directory to the path
noremap <leader>e :edit %%

" make <leader>, jump to the alternate file
nnoremap <leader>, <C-^>

" select last paste in visual mode
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" leader gg acks for the given text.
vnoremap <leader>gg y:Ack "<c-r>""<cr>

" leader ,aa does a wip commit
nnoremap <leader>a :w <bar> :Git wip <cr> <bar>:sleep 300m<cr><bar> :e %<cr>

" leader s sends the up arrow to the right pane, followed up enter (twice, to
" clear the screen). Basically it will re-run the last command on your right
" pane
nnoremap <silent> <leader>s :!tmux send-keys -t right "Up" C-m <CR><CR>
" FZF
" -----------------
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>v :Buffers<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

" make search a little easier right away (less escaping)
nnoremap / /\v
vnoremap / /\v

" complete the longest line. Supertab should have an alternative methinks
inoremap <leader>l <C-X><C-L>
" mappings for tests using janko-m/vim-test
nmap <silent> <leader>t :w <bar> :TestNearest<CR>
nmap <silent> <leader>T :w <bar> :TestFile<CR>
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
" {{{ CursorLine highlight
:hi CursorLine   cterm=NONE ctermbg=Black
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END
"}}}
" {{{ Startify Start screen customization
let g:startify_custom_header = [] "turn off random quote
let g:startify_change_to_dir = 0
" let g:startify_custom_header =
 "    \ map(readfile(glob('~/vimwiki/commands_to_learn.md'), '', 10), 'repeat(" ", 8) . v:val')
" let g:startify_bookmarks = [ {'o': '~/secret_vimwiki/index.md'} ]

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
" {{{ Timetrap autocommand
if has("autocmd")
  augroup module
    autocmd!
    autocmd BufRead,BufNewFile *get_note* setlocal spell
  augroup END
endif
" }}}
" {{{ Rubyish autocommands
if has("autocmd")
  augroup filetype_ruby
    autocmd!
    autocmd BufRead,BufNewFile .pryrc set filetype=ruby
    autocmd BufNewFile,BufRead *.ejs set filetype=html
    autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
    highlight def link rubyRspec Function
    autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,*.rabl,irb_tempfile*} set ft=ruby
    autocmd FileType ruby nnoremap <buffer> <Leader>d orequire "pry"<cr>binding.pry<esc>:w<cr>
    autocmd FileType ruby setlocal foldmethod=manual
  augroup END
endif
" }}}
" {{{ Javascript autocommands
if has("autocmd")
  augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <Leader>d odebugger;<esc>:w<cr>
    autocmd FileType coffee nnoremap <buffer> <Leader>d odebugger<esc>:w<cr>
  augroup END
endif
" }}}
" {{{ Elixir specific commands
if has("autocmd")
  augroup filetype_elixir
    autocmd!
    autocmd FileType elixir nnoremap <buffer> <Leader>d orequire IEx<cr>IEx.pry<esc>:w<cr>
    autocmd FileType elixir let g:ale_enabled=0
    autocmd FileType elixir nnoremap <buffer> <Leader>f :Files<cr>
  augroup END
endif
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
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END
" }}}
" {{{ python autocmd
augroup python_autocmd
  autocmd!
  autocmd FileType python set tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType python nnoremap <buffer> <Leader>d oimport ipdb; ipdb.set_trace()<esc>:w<cr>
augroup END
" }}}
" {{{ augroup for xml indenting
"tidy xml from
"http://ku1ik.com/2011/09/08/formatting-xml-in-vim-with-indent-command.html
au FileType xml setlocal equalprg=tidy\ -xml\ -i\ -w\ 0\ -q\ -\ 2>\/dev\/null\ \|\|\ true
" }}}
" {{{ Vimwiki plugin settings and specific functions: "
let g:vimwiki_folding = 'expr'
"
function! OpenSecretCalendar()
  call vimwiki#base#goto_index(2)
  execute ':Calendar'
endfunction
nnoremap <leader>c :call OpenSecretCalendar()<cr>

function! ConvertMarkdownToPDF()
  let path_to_file = shellescape(expand('%'), 1)
  let output_filename = '~/Desktop/' . shellescape(expand('%:t:r'), 1) . '.pdf'
  let command = ':! pandoc -V urlcolor=cyan -V geometry:margin=1in -f markdown_github --latex-engine=xelatex ' . path_to_file . ' -o ' . output_filename
  execute command
  " exec ':silent !open ' . output_filename . ' &'
endfunction

augroup associate_markdown_styles
  autocmd!
  let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'yaml', 'haml', 'bash=sh']
augroup END

augroup crontab_setting
  autocmd!
  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

let g:vimwiki_folding='expr' "this allows the folding to work for markdown

" source ~/dotfiles/vim/secret_vim_config.vim

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
" {{{ function to replace current string

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace String
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ReplaceString()
    let old_name = @"
    let new_name = input('replace with: ')
    if new_name != '' && new_name != old_name
        exec ':%s/' . old_name . '/' . new_name . "/gc"
    endif
endfunction
vnoremap <leader>gn y:call ReplaceString()<cr>
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
      \ "app/services/*.rb": {
      \   "command": "service",
      \   "test": [
      \     "spec/services/%s_spec.rb"
      \   ],
      \  "affinity": "model"
      \ },
      \ "app/forms/*.rb": {
      \   "command": "form",
      \   "test": [
      \     "spec/forms/%s_spec.rb"
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
" {{{ vim-test settings
  let test#strategy = "dispatch"
  let g:dispatch_compilers = {'elixir': 'exunit'}
" }}}
" {{{ Closetag Settings
let g:closetag_filenames = "*.html,*.xhtml,*.erb,*.vue"
let g:closetag_xhtml_filenames = '*.xhtml,*.vue,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'
au FileType xml,html,phtml,php,xhtml,js,vue,eruby let b:delimitMate_matchpairs = "(:),[:],{:}"
" }}}
" {{{ Undo settings
set undofile
set undodir=$HOME/.vim/undo
augroup vimrc
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
  autocmd BufWritePre /private/* setlocal noundofile
augroup END
" }}}
" {{{ Ale setup
let g:ale_set_highlights = 0
" }}}
