
let $PYTHONPATH='.'

set nocompatible
set path+=**,~/
set wildignore+=**.cout,**.xcl,**.pbi,**.o,**.i
command! MakeTags !ctags -R .

" Clear any existing autocommands..
autocmd!
autocmd FileType help wincmd L

if has('syntax') && (&t_Co > 2)
  syntax on
  set foldmethod=syntax
endif

let g:netrw_banner=0
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1  " open splits to right
let g:netrw_list_style=3 " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_browse_split=4

set relativenumber
set cursorline

execute pathogen#infect()

" Generate helptags for all plugins if not present
execute pathogen#helptags()

"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_signs=1
"let g:syntastic_python_python_exec='python3'
"let g:syntastic_python_checkers=['pyflakes', 'flake8']
"let g:syntastic_python_checkers=['pylint', 'pyflakes']
"let g:syntastic_check_on_open=0
"let g:syntastic_auto_jump = 1
" Rung linting and so on when reading, writing and on normal mode changes
call neomake#configure#automake('rnw', 750)


inoremap jk <esc>

" CtrlP fuzzy file search
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|output\|test_logs\|test_releases\|test_logs_split$',
  \ }


set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me (who is this 'me', anyways?):
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

" display the current mode and partially-typed commands in the status line:
set showmode
set showcmd

" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars+=tab:' . nr2char(187) . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)

" have the mouse enabled all the time:
" set mouse=a

" don't have files trying to override this .vimrc:
set nomodeline

" * Text Formatting -- General

" don't make it look like there are line breaks where there aren't:
set nowrap

" identation
set tabstop=4
set shiftwidth=4
"set shiftround
set noexpandtab
" Don't put comments on the first coloumn when indenting
inoremap # X#

" normally don't automatically format 'text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
set textwidth=79

" enable filetype detection:
if has("autocmd")
  filetype indent on
endif

" for C-like programming, have automatic indentation:
autocmd FileType c,cpp,slang set cindent

" for actual C (not C++) programming where comments have explicit end
" characters, if starting a new line in the middle of a comment automatically
" insert the comment leader characters:
autocmd FileType c set formatoptions+=ro cindent

" for Perl programming, have things in braces indenting themselves:
autocmd FileType perl set smartindent

" for PHP programming, have things in braces indenting themselves:
autocmd FileType php set autoindent

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML:
autocmd FileType xhtml,html,css set expandtab tabstop=2 shiftwidth=2

" bash/sh
autocmd Filetype bash,sh set fo+=tl

" tex
autocmd Filetype tex set fo+=tln

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8

" e-mail \o/
autocmd FileType mail set com=s1:/*,mb:*,ex:*/,n:>,b:#,b:%,b:=,b:-,b:+,b:o fo=tqlnor

" Python
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 smartindent "python_highlight_all=1

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" page down with <Space> (like in `Lynx', `Mutt', `Pine', `Netscape Navigator',
" `SLRN', `Less', and `More'); page up with - (like in `Lynx', `Mutt', `Pine'),
" or <BkSpc> (like in `Netscape Navigator'):
noremap <Space> <PageDown>
noremap <BS> <PageUp>
noremap - <PageUp>
" [<Space> by default is like l, <BkSpc> like h, and - like k.]

" scroll the window (but leaving the cursor in the same place) by a couple of
" lines up/down with <Ins>/<Del> (like in `Lynx'):
" noremap <Ins> 1<C-Y>
" noremap <Del> 1<C-E>
" [<Ins> by default is like i, and <Del> like x.]

" use <F6> to cycle through split windows (and <Shift>+<F6> to cycle backwards,
" where possible):
nnoremap <F6> <C-W>w
nnoremap <S-F6> <C-W>W

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>
" [<Ctrl>+N by default is like j, and <Ctrl>+P like k.]

" have % bounce between angled brackets, as well as t'other kinds:
set matchpairs+=<:>

" have <F1> prompt for a help topic, rather than displaying the introduction
" page, and have it do this from any mode:
nnoremap <F1> :help<Space>
vmap <F1> <C-C><F1>
omap <F1> <C-C><F1>
map! <F1> <C-C><F1>


" * Keystrokes -- Formatting

" have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" have the usual indentation keystrokes still work in visual mode:
"vnoremap <C-T> >
"vnoremap <C-D> <LT>
"vmap <Tab> <C-T>
"vmap <S-Tab> <C-D>

" * Keystrokes -- Insert Mode

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
"inoremap <Tab> <C-T>
"inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

set backupdir=~/.vim/backup
set dir=~/.vim/backup
let myvar = strftime("%y%m%d_%Hh%M")
let myvar = "set backupext=_". myvar
execute myvar
set backup

" We play utf-8
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8
"au BufNewFile,BufRead mutt*    set tw=77 ai nocindent fileencoding=utf-8
"au BufNewFile,BufRead .drafts/*    set tw=77 ai nocindent fileencoding=utf-8

"function! CleverTab()
"	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"		return "\<Tab>"
"	else
"		return "\<C-N>"
"endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

set laststatus=2
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
