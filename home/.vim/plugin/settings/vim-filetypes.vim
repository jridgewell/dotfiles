" Some file types should wrap their text
function! s:setupWrapping()
    setlocal wrap
    setlocal linebreak
    setlocal textwidth=72
    setlocal nolist
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match ColorColumn '\%>72v.\+'
endfunction

if has("autocmd")
    " In Makefiles, use real tabs, not tabs expanded to spaces
    au FileType make setlocal noexpandtab

    " Make sure all mardown files have the correct filetype set and setup wrapping
    au FileType markdown call s:setupWrapping()
    " Key mapping to open markdown files in marked.app
    au FileType markdown nnoremap <leader>m :silent !open -a Marked.app '%:p'<CR>

    " Treat JSON files like JavaScript
    au BufNewFile,BufRead *.json set ft=javascript

    " Set tabstop to 2 for ruby files
    au Filetype ruby,eruby,cucumber setlocal softtabstop=2 tabstop=2 shiftwidth=2

    " Remember last location in file, but not for commit messages.
    au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif
