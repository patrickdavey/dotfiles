call pathogen#infect()

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
  augroup END
endif
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode
set nocompatible

  "make tab match brackets
nnoremap <tab> %
vnoremap <tab> %

  "handle long lines - from http://stevelosh.com/blog/2010/09/coming-home-to-vim/?
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


syntax on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showmatch
set ruler
let dialect='UK'
set mousemodel=popup_setpos
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

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
"set hlsearch "highlight searching
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
