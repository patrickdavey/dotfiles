call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
"add in the nerdtree open map"
map <F3> :NERDTreeToggle<CR>
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif

augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
augroup END
au BufNewFile,BufRead *.ejs set filetype=html

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Syntastic on by default, turn it off for html
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'] }

" "Hidden" buffers -- i.e., don't require saving before editing another file.
" Calling quit will prompt you to save unsaved buffers anyways.
:set hidden

" The escape key is a long ways away. This maps it to the sequence 'kj'
:map! kj <esc>

" store swapfiles locally
:set directory=$HOME/.vim/swapfiles//


"  Use smart case, if we use an uppercase letter
"  then it will match on case.
:set smartcase


" Use UTF-8 encoding
:set encoding=utf-8

" needed for vimwiki
filetype plugin on

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
  endif
  au BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')
endif

autocmd FileType vimwiki set spell spelllang=en_gb
"stolen from Gary Bernhart - open file at last position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" |
  \ endif


nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set nocompatible

" big old history - needs to come after nocompatible
set history=1000

set relativenumber
set number
nnoremap <F4> :set nonumber! norelativenumber! <CR>
set cpoptions+=$

if (system('uname') =~ "Darwin")
  colorscheme jellybeans
else
  colorscheme peachpuff
endif

set textwidth=79
set formatoptions=qrn1

  "remove arrow keys"
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"nnoremap j gj
"nnoremap k gk

"better control of window swapping"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

syntax on
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
let dialect='UK'
set mousemodel=popup_setpos
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,*.rabl,irb_tempfile*} set ft=ruby

augroup encrypted
    au!

    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg set bin
    autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt 2> /dev/null
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg set nobin
    autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg   '[,']!gpg --default-recipient-self -ae 2>/dev/null
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost  *.gpg   u

    " Fold entries by default
    autocmd BufReadPre,FileReadPre      *.gpg set foldmethod=expr
    autocmd BufReadPre,FileReadPre      *.gpg set foldexpr=getline(v:lnum)=~'^\\s*$'&&getline(v:lnum+1)=~'\\S'?'<1':1
augroup END

" commands copied from  http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set hlsearch "highlight searching
set incsearch "set incremental search"

"clear the highlight after a return is pressed
nnoremap <CR> :noh<CR><CR>
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

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

" this enables "visual" wrapping
set wrap

" this turns off physical line wrapping (ie: automatic insertion of newlines)
set textwidth=0 wrapmargin=0


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

set backspace=indent,eol,start

let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git/', 'cd %s && git ls-files'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" allow w!! to write as sudo
cmap w!! w !sudo tee > /dev/null %

" folding info
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1
let g:vim_markdown_folding_disabled=1
let python_highlight_all = 1


" leader mappings

" save the bugger
nnoremap <Leader>w :w<CR>

" always show vim-airline
let g:airline_powerline_fonts=1
set laststatus=2

"allow * and # to search using highlighted word in visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

set clipboard=unnamedplus

vnoremap <leader>gg y:Ack <c-r>"<cr>

"tidy xml from
"http://ku1ik.com/2011/09/08/formatting-xml-in-vim-with-indent-command.html
au FileType xml setlocal equalprg=tidy\ -xml\ -i\ -w\ 0\ -q\ -\ 2>\/dev\/null\ \|\|\ true
set clipboard=unnamed
