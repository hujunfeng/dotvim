set guioptions=egmt     " remove toolbar and scrollbar

set guifont=Monaco:h16

set lines=35            " default height of GUI window

" Columns should be >= 83, otherwise some error occur in Latex-Suite.
" See: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=312816
set columns=90          " default width of GUI window

" set cursorline        " hightlight current line

" toggle the right scrollbar
" nnoremap <silent> <leader>rs :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
