" Open NERDTree easily
map <silent> <leader>n :NERDTreeToggle<CR>

" Let NERDTree take over NetRW
let g:NERDTreeHijackNetrw=1

" Look pretty
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1

" I like to edit .files...
let g:NERDTreeShowHidden=1

" Change to this directory on startup
let g:NERDTreeChDirMode=1

" Refresh NERDTree when vim gains focus or a file is written
if has("autocmd")
    augroup AuNERDTreeCmd
        autocmd AuNERDTreeCmd FocusGained * call s:UpdateNERDTree()
        autocmd AuNERDTreeCmd BufWritePost * call s:UpdateNERDTree()
        function! s:UpdateNERDTree(...)
            let stay=0
            if(exists("a:1"))
                let stay=a:1
            endif
            if exists("t:NERDTreeBufName")
                let nr=bufwinnr(t:NERDTreeBufName)
                if nr != -1
                    exe nr . "wincmd w"
                    exe substitute(mapcheck("R"), "<CR>", "", "")
                    if !stay
                        wincmd p
                    endif
                endif
            endif
        endfunction
    augroup END
endif
