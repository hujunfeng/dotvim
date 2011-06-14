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
map <leader>_ :edit $MYVIMRC<cr>
map <leader>so :source $MYVIMRC<cr>

" guess encoding of files along this list
set fileencodings=utf-8,chinese,latin1
" default encoding of buffers
set encoding=utf-8

" dictionary location
set dict+=/usr/share/dict/words

" be able to edit other buffers even if changes of current buffer have
" not been saved
set hidden

" }}}

" Formatting/Typesetting {{{ ----------------------------------------

" make the backspace key useful
set backspace=indent,eol,start

" indent style
set autoindent
set smartindent
" enable cindent when filetype is a C-styling language
autocmd Filetype c,cpp,objc,java,javascript setlocal cindent

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
nnoremap <silent> <leader>f gwip

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
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
" autoformat the entire file
nmap <leader>= :call Preserve("normal gg=G")<CR>

let g:loaded_matchparen=1

" }}}

" Files & Backups {{{ ---------------------------------------------

" fast switching to alternative file
" nnoremap <leader>e :e #<CR>

" ignore these files
set wildignore=*.o,*.obj,*.bak,*.exe,*.pdf,*.jpg,*.png,*.rar,*.zip,*.tar.*

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
nmap <silent> <leader>sp :call ToggleSpell()<CR>

" }}}

" UI {{{ -----------------------------------------------------------

" always show status line
"set laststatus=2

" always show current position
set ruler

" show partial command in the last line of screen
set showcmd

" height of command line
"set cmdheight=2

" open a little window showing command-line completion
set wildmenu

" toggle the line number
nmap <silent> <leader>ln :set nu!<cr>

" toggle the invisible chars, eg. tabstops and eols
nmap <silent> <leader>i :set list!<cr>

" customize the symbols for tabstops and eols
set listchars=tab:›\ ,eol:¬,trail:-

" show syntax highlighting groups for word under cursor
nmap <c-s-p> :call <sid>SynStack()<cr>
function! <sid>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" toggle background between dark and light, and also change colorscheme
" correspondingly
" function! ToggleBackground()
	" if &background == "light"
		" set background=dark
		" colo solarized
	" else
		" set background=light
		" colo solarized
	" endif
" endfunction
" map <F3> :call ToggleBackground()<cr>

" increase/decrease the number of columns
nmap <silent> <leader>> :set columns+=15 lines+=5<cr>:set columns lines<cr>
nmap <silent> <leader>< :set columns-=15 lines-=5<cr>:set columns lines<cr>
nmap <silent> <leader>+ :set lines+=5<cr>:set lines<cr>
nmap <silent> <leader>- :set lines-=5<cr>:set lines<cr>

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
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <c-f> <right>

" use shift-tab to unindent the current line in Insert mode
imap <s-tab> <c-o><<

" use tab to switch between windows
" nmap <tab> <c-w><c-w>

" clear highlights
nmap <leader>n :noh<cr>

" move text, but keep highlight
" http://www.mattrope.com/computers/conf/vimrc.html
vnoremap > ><cr>gv
vnoremap < <<cr>gv

" page down, page up; H is to keep cursor at the first line
nmap <space> <c-f>
nmap <s-space> <c-b>H

" quickly insert an empty line
nmap <c-cr> o<esc>0D

" copy to the system clipboard
nmap <leader>y "*y
vmap <leader>y "*y

" paste from the clipboard
nmap <leader>p "*p

" switch to next/previous buffer
nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>
nmap <c-tab> :bn<cr>

" cd to the directory containing the file in the current buffer
" http://www.derekwyatt.org/vim/the-vimrc-file/toggling-and-shortening/
nmap <leader>cd :lcd %:h<cr>:pwd<cr>

" shortcut to change to playground directory
nmap <leader>0 :cd ~/Projects/playground<cr>

" shortcut to delete current buffer
nmap <leader>x :bd<cr>
nmap <leader>X :bd!<cr>

" duplicate selected lines in visual mode
vnoremap D y'>pgv

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
nmap <leader>go :call OpenURI()<CR>

" look for current word in help documents
function! HelpCurrentWord()
	let l:word_under_cursor = expand("<cword>")
	execute "help " . l:word_under_cursor
endfunction
nmap <leader>hc :call HelpCurrentWord()<cr>

" search Google for current word
function! GoogleCurrentWord()
	let l:cword = expand("<cword>")
	execute "silent !open \"http://www.google.com/search?q=" . l:cword . "\""
endfunction
nmap <leader>gg :call GoogleCurrentWord()<cr>

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

" File Types {{{ ----------------------------------------------------

if has("autocmd")

	" set whilespaces preferences based on file types
	autocmd FileType html,xhtml,xml setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType json,javascript,css setlocal ts=2 sts=2 sw=2 expandtab

	" do not wrap lines in Quickfix window
	autocmd FileType qf setlocal nowrap

endif

" }}}

" Plugins {{{ -------------------------------------------------------

" vimwiki
" let g:vimwiki_list = [{'path': '~/Dropbox/Docs/vimwiki'}]	" home path
" let g:vimwiki_menu = ''		" turn off the menu

" NERDCommenter
let NERDMenuMode = 0		" turn off the menu
let NERDSpaceDelims = 1		" add a space after the delimiter
map <d-/> <plug>NERDCommenterToggle
map <leader>c<space> <plug>NERDCommenterToggle
imap <c-c> <plug>NERDCommenterInInsert

" taglist
" nnoremap <silent> ,t :TlistToggle<cr>
" remove extra information and blank lines from the taglist window
" let Tlist_Compact_Format = 1
" let Tlist_Use_Right_Window = 1
" let Tlist_Enable_Fold_Column = 0
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_Use_SingleClick = 1    
" let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'

" BufExplorer
" nnoremap <leader>B :BufExplorer<cr>
nmap <silent> <leader>e :BufExplorer<cr>

" javacomplete
if has("autocmd")
	autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif

" hexHighlight
" Usage: highlight hex codes of format #ffffff or #fff in that color
" map <leader><F2>

" Solarized colorscheme
" use different default colorschemes for GUI and terminal
let g:solarized_contrast="high"    " default value is normal
let g:solarized_diffmode="high"    " default value is normal
" let g:solarized_visibility="high"  " default value is normal
set background=light
silent! colorscheme solarized

" Toggle background between dark and light
function! SCToggleBackground()
	let &background = (&background == "dark" ? "light" : "dark")
	if exists("g:colors_name")
		exe "colorscheme " . g:colors_name
	endif
endfunction
nmap <leader><F3> :call SCToggleBackground()<cr>

" tagbar
nnoremap <silent> ,t :TagbarToggle<cr>
let g:tagbar_autofocus = 1
let g:tagbar_usearrows = 1

" }}}

" vim: set ts=2 sts=2 sw=2 fdm=marker:
