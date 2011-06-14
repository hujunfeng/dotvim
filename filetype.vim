" custom filetype file

if exists("did\_load\_filetypes")
    finish
endif

" Markdown (additional extensions)
au! BufRead,BufNewFile *.{md,text} setfiletype markdown

" JSON
au! BufRead,BufNewFile *.json setfiletype json

" Go language
au! BufRead,BufNewFile *.go setfiletype go

" Gnuplot
au! BufRead,BufNewFile *.{plt,gnuplot,gp} setfiletype gnuplot
