" Load Plugins using Pathogen {{{ -----------------------------------

filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype indent plugin on

" }}}

" General {{{ -------------------------------------------------------

" not interested to be compatible with vi
set nocompatible

" turn on syntax highlight
syntax on

" number of Ex commands to remember
set history=400

" automatically reload a file when it is changed
set autoread

" shortcuts to open and save .vimrc
map <Leader>_ :edit $MYVIMRC<CR>

" source current buffer
map <Leader>so :source %<CR>

" guess encoding of files along this list
set fileencodings=ucs-bom,utf-8,chinese,latin1
" default encoding of buffers
set encoding=utf-8

" dictionary location
set dict+=/usr/share/dict/words

" be able to edit other buffers even if changes of current buffer have
" not been saved
set hidden

" place the cursor at the column where is was the last time the buffer
" was edited
set nostartofline

" use option (alt) as meta key.
if has('gui_macvim')
  set macmeta
endif

" }}}

" Formatting/Typesetting {{{ ----------------------------------------

" make the backspace key useful
set backspace=indent,eol,start

" indent style
set autoindent
set smartindent
" enable cindent when filetype is a C-styling language
autocmd! Filetype c,cpp,objc,java,javascript setlocal cindent

" force the length of a <Tab> to be 4 spaces, instead of the default 8
set tabstop=4

" indent by 4 spaces while (auto)indenting, used for 'cindent', >>, <<
set shiftwidth=4

" number of spaces a <Tab> counts for by <Tab> or <BS> operation
set softtabstop=4

" turn tabs into spaces, but still can insert hard tab by <C-v> <tab>
set noexpandtab

set textwidth=72

" set cc=+1
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey

" format the current paragraph;
" use 'gw' instead of 'gq' to keep the cursor position
nnoremap <silent> <Leader>f gwip

"set formatprg=par

" save the cursor state, execute a command and restore the cursor
" http://vimcasts.org/episodes/tidying-whitespace/
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" remove trailling spaces
nmap <Leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
" autoformat the entire file
nmap <Leader>= :call Preserve("normal gg=G")<CR>

let g:loaded_matchparen=1

" set whilespaces preferences based on file types
autocmd! FileType html,xhtml,xml setlocal ts=2 sts=2 sw=2 expandtab
autocmd! FileType json,javascript,css setlocal ts=2 sts=2 sw=2 expandtab

" do not wrap lines in Quickfix window
autocmd! FileType qf setlocal nowrap

" set file type to markdown for files opened from Notational Velocity
autocmd! BufRead /Users/hjunfeng/Library/Application\ Support/Notational\ Data/* set ft=markdown

" }}}

" Files & Backups {{{ ---------------------------------------------

" fast switching to alternative file
" nnoremap <Leader>e :e #<CR>

" ignore these files
set wildignore=*.o,*.obj,*.bak,*.exe,*.pdf,*.jpg,*.png,*.rar,*.zip,*.tar.*,*.class,.git,.svn,*.a,*.out

" enable backups
set backup
set backupdir=~/.vim/tmp/backup

" set swap file directory
set dir=~/.vim/tmp/swap

" enable persistent undo
if v:version > 702
  set undodir=~/.vim/tmp/undo
  set undofile
endif

" }}}

" Spell Checking {{{ ------------------------------------------------

function! ToggleSpell()
  if !exists("b:spell")
    setlocal spell spelllang=en_us
    let b:spell = 1
  else
    setlocal nospell
    unlet b:spell
  endif
endfunction

" toggle spell checking on and off
nmap <silent> <Leader>sp :call ToggleSpell()<CR>

" correct last mistake in insert mode
imap <C-l> <Esc>[s1z=`]a

" correct current word with the first suggestion
nmap zs 1z=

" }}}

" UI {{{ -----------------------------------------------------------

" always show status line
set laststatus=2
set statusline=																" reset statusline
set statusline+=%n:														" buffer number
set statusline+=%<%f\ %m%r										" file name and flags
set statusline+=[%{strlen(&ft)?&ft:'none'},		" filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},	" encoding
set statusline+=%{&fileformat}]								" file format
set statusline+=%{SpellOn()}									" spell status
set statusline+=%=\ %l,%-7.(%c%V%)\ %P				" line number, column number and

function! SpellOn()
	if &spell
		return ' (spell)'
	else
		return ''
	endif
endfunction

" always show current position
set ruler

" show partial command in the last line of screen
set showcmd

" height of command line
"set cmdheight=2

" open a little window showing command-line completion
set wildmenu

" toggle the line number
nmap <silent> <Leader>ln :set nu!<CR>

" toggle the invisible chars, eg. tabstops and eols
nmap <silent> <Leader>i :set list!<CR>

" customize the symbols for tabstops and eols
set listchars=tab:›\ ,eol:¬,trail:·

" show syntax highlighting groups for word under cursor
nmap <C-P> :call <sid>SynStack()<CR>
function! <sid>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" increase/decrease the number of columns
nmap <silent> <Leader>> :set columns+=15 lines+=5<CR>:set columns lines<CR>
nmap <silent> <Leader>< :set columns-=15 lines-=5<CR>:set columns lines<CR>
nmap <silent> <Leader>+ :set lines+=5<CR>:set lines<CR>
nmap <silent> <Leader>- :set lines-=5<CR>:set lines<CR>

" }}}

" Mappings {{{ ------------------------------------------------------

" shortcuts for moving between tabs.
" move to the tab to the left
" nmap <A-j> gT
" imap <A-j> <esc>gT
" nmap <c-s-tab> gT
" imap <c-s-tab> <esc>gT
" move to the tab to the right
" nmap <A-k> gt
" imap <A-k> <esc>gt
" nmap <c-tab> gt
" imap <c-tab> <esc>gt

" readline-like cursor movements in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" use shift-tab to unindent the current line in Insert mode
imap <S-Tab> <C-o><<

" use tab to switch between windows
" nmap <tab> <c-w><c-w>

" clear highlights
nmap <Leader>n :noh<CR>

" move text, but keep highlight
" http://www.mattrope.com/computers/conf/vimrc.html
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" page down, page up; H is to keep cursor at the first line
nmap <space> <c-f>
nmap <s-space> <c-b>H

" copy to the system clipboard
nmap <Leader>y "*y
vmap <Leader>y "*y

" paste from the clipboard
nmap <Leader>p "*p

" switch to next/previous buffer
nmap <C-Tab> :bn<CR>
nmap <C-S-Tab> :bp<CR>
imap <C-Tab> <C-o>:bn<CR>
imap <C-S-Tab> <C-o>:bp<CR>

" cd to the directory containing the file in the current buffer
" http://www.derekwyatt.org/vim/the-vimrc-file/toggling-and-shortening/
nmap <Leader>cd :lcd %:h<CR>:pwd<CR>

" shortcut to change to playground directory
nmap <Leader>0 :cd ~/Projects/playground<CR>

" shortcut to delete current buffer
nmap <Leader>x :bd<CR>
nmap <Leader>X :bd!<CR>

" duplicate selected lines in visual mode
vnoremap D y'>pgv

" execute current line as a Ex command
nmap <Leader>. :call ExecuteCurrentLine()<CR>
function! ExecuteCurrentLine()
	execute getline('.')
endfunction

" don't use Ex mode, use Q for formatting
nnoremap Q gq

" open and close quickfix list
nmap <Leader>co :copen<CR>
nmap <Leader>ce :cclose<CR>

" move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <C-M-n> mz:m+<CR>`z
nmap <C-M-p> mz:m-2<CR>`z
vmap <C-M-n> :m'>+<CR>`<my`>mzgv`yo`z
vmap <C-M-p> :m'<-2<CR>`>my`<mzgv`yo`z

" join current line with the line above it
nmap <Leader>J kddpkJ

" }}}

" External Reference {{{ --------------------------------------------

" look for URI under cursor and open the URI in the default browser
function! OpenURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  echo s:uri
  if s:uri != ""
    exec "silent !open \"" . s:uri . "\""
  else
    echo "No URI found in current line."
  endif
endfunction
nmap <Leader>go :call OpenURI()<CR>

" look for current word in help documents
function! HelpCurrentWord()
  let l:word_under_cursor = expand("<cword>")
  execute "help " . l:word_under_cursor
endfunction
nmap <Leader>hc :call HelpCurrentWord()<CR>

" search Google for current word
function! GoogleCurrentWord()
  let l:cword = expand("<cword>")
  execute "silent !open \"http://www.google.com/search?q=" . l:cword . "\""
endfunction
nmap <Leader>gg :call GoogleCurrentWord()<CR>

" }}}

" Abbreviations {{{ -------------------------------------------------

" typos correction
iab teh the
iab hte the
iab Teh The
iab Hte the
iab tihs this
iab taht that
iab oen one

" shortcuts for common words
iab j@ jeffjunfenghu@gmail.com
iab h@ hjunfeng@comp.nus.edu.sg

" }}}

" Search {{{ --------------------------------------------------------

" enable incremental search
set incsearch

" enable highlight search
set hlsearch

" ignore the case of normal letter
set ignorecase

" ignore the case only if the pattern is lowercase
set smartcase

" }}}

" Plugins {{{ -------------------------------------------------------

" NERDCommenter
let NERDMenuMode = 0        " turn off the menu
let NERDSpaceDelims = 1     " add a space after the delimiter
map <D-/> <plug>NERDCommenterToggle
imap <C-c> <plug>NERDCommenterInInsert

" BufExplorer
" nnoremap <Leader>B :BufExplorer<CR>
nmap <silent> <Leader>e :BufExplorer<CR>

" hexHighlight
" Usage: highlight hex codes of format #ffffff or #fff in that color
" map <Leader><F2>

" Solarized colorscheme
" use different default colorschemes for GUI and terminal
let g:solarized_contrast="high"    " default value is normal
let g:solarized_diffmode="high"    " default value is normal
" let g:solarized_visibility="high"  " default value is normal
set background=light
silent! colorscheme solarized
hi LineNr guifg=#d75f00 guibg=NONE ctermfg=Yellow ctermbg=NONE

" Toggle background between dark and light
function! SCToggleBackground()
  let &background = (&background == "dark" ? "light" : "dark")
  if exists("g:colors_name")
    exe "colorscheme " . g:colors_name
  endif
endfunction
nmap <Leader><F3> :call SCToggleBackground()<CR>

" tagbar
nmap <silent> <Leader>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autofocus = 1
let g:tagbar_width = 35
let g:tagbar_expand = 1
let g:tagbar_type_tex = {
  \ 'ctagstype' : 'latex',
  \ 'kinds'     : [
    \ 's:sections',
    \ 'g:graphics',
    \ 'l:labels',
    \ 'r:refs:1',
    \ 'p:pagerefs:1'
  \ ],
  \ 'sort'      : 0,
\ }

" delimitMate
" imap <unique> <buffer> <C-j> <Plug>delimitMateS-Tab

" LustyExplorer
nmap ,f :LustyFilesystemExplorer<CR>
nmap ,r :LustyFilesystemExplorerFromHere<CR>
nmap ,e :LustyBufferExplorer<CR>
nmap ,g :LustyBufferGrep<CR>

" command-t
let g:CommandTMaxHeight = 20
nmap <silent> ,t :CommandT<CR>
nmap <silent> ,b :CommandTBuffer<CR>

" css3 syntax
autocmd! BufRead,BufNewFile *.css set ft=css syntax=css3

" preview
nmap ,p :Preview<CR>
let g:PreviewMarkdownExt = 'markdown,md,mkd,mkdn,mdown,txt'

" nerdtree
nmap <Leader>q :NERDTreeToggle<CR>

" supertab
let g:SuperTabDefaultCompletionType = "context"

" javacomplete
autocmd! Filetype java setlocal omnifunc=javacomplete#Complete 

" Vim-Latex
" Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" }}}

" vim: set ts=2 sts=2 sw=2 fdm=marker:
