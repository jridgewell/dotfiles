if has("gui_running")
    " Map command-[ and command-] to indenting or outdenting
    " while keeping the original selection in visual mode
    vmap <D-]> >gv
    vmap <D-[> <gv
    nmap <D-]> >>
    nmap <D-[> <<
    imap <D-]> <Esc>>>a
    imap <D-[> <Esc><<a

    " Disable the scrollbars
    set guioptions-=r
    set guioptions-=L
    " Disable the macvim toolbar
    set guioptions-=T"
endif
