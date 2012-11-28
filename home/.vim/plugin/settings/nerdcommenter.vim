" NERDCommenter mappings
if has("gui_running")
   map  <D-/> <Plug>NERDCommenterToggle
   imap <D-/> <Esc><Plug>NERDCommenterToggle
else
   map  <leader>/ <Plug>NERDCommenterToggle
   imap <leader>/ <Esc><Plug>NERDCommenterToggle
endif
