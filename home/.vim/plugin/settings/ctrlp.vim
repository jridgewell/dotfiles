" Make Ctrl-P appear in Command-T style
let g:ctrlp_map = '<leader>t'
nnoremap <silent> <leader>t :CtrlP<CR>

" Search buffers
nnoremap <silent> <leader>b :CtrlPBuffer<CR>

" Map Command-T to its namesake
if has("gui_running") && has("gui_macvim")
    map <silent> <D-t> :CtrlP<CR>
    map <silent> <D-b> :CtrlPBuffer<CR>
endif

" Refresh Ctrl-P when vim gains focus or a file is written
if has("autocmd")
    augroup AuCtrlPCmd
        autocmd AuCtrlPCmd FocusGained * call s:CtrlPFlush()
        autocmd AuCtrlPCmd BufWritePost * call s:CtrlPFlush()
        function! s:CtrlPFlush(...)
            if exists(":ClearCtrlPCache") == 2
                ClearCtrlPCache
            endif
        endfunction
    augroup END
endif
