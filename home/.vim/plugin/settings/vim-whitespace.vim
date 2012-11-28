" Highlight trailing whitespace and spaces before a tab
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Properly indent entire file
nmap <leader>fef ggVG=
