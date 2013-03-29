" Leader key mapping
let mapleader = " "
nnoremap <Space> <Nop>

" Other utility keys
nnoremap - <Nop>

" Use Command-T from the git root folder if any
nnoremap <silent> <Leader>t :CommandT `git root`<CR>
"nnoremap <silent> <Leader>t :CommandT<CR>

" Leader key timeout
set timeoutlen=400
set ttimeoutlen=400

" Virtual moving through wrapped lines
nnoremap j gj
nnoremap k gk

" Toggle file tree
nnoremap <Leader>nt :NERDTreeToggle<CR>

nnoremap <Leader>lt :TlistToggle<CR>

" Yank entire buffer
nnoremap <Leader>yy mzggyG'zmz

" Auto indent entire buffer
nnoremap <Leader>ii mzgg=G'zmz

" Follow links in help
nnoremap <C-f> <C-]>

" Show invisibles
nmap <leader>si :set list!<CR>
set listchars=tab:▸\ ,eol:¬,trail:◻

" Unbind help toggle
noremap <F1> <Nop>

" Exit insert mode mapping
imap uu <Esc><Esc>

" Tabularize mappings {
nmap <Leader>= :Tabularize /=<CR>
nmap <Leader>: :Tabularize /^[^:]*:\zs/l1r0<CR>
nmap <Leader>. :Tabularize /\.<CR>:Tabularize /::=<CR>
" }
