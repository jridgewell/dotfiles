" Double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<CR>
map <leader>ee :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Use :w!! to write to a file using sudo
cmap w!! %!sudo tee > /dev/null %
