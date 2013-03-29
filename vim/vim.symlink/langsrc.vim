" Language-specific settings
" Author: poscar

" Filetype detection {
au BufNewFile,BufRead *.t2t set ft=txt2tags
" }

" 2-space indented languages {
au FileType java,cpp,ruby,jade,scss,sass,html,javascript,mustache,haskell,php setlocal tabstop=2
au FileType java,cpp,ruby,jade,scss,sass,html,javascript,mustache,haskell,php setlocal shiftwidth=2
au FileType java,cpp,ruby,jade,scss,sass,html,javascript,mustache,haskell,php setlocal expandtab
au FileType java,cpp,ruby,jade,scss,sass,html,javascript,mustache,haskell,php setlocal softtabstop=2
" }

" Text formatting {
au FileType markdown setlocal textwidth=74
au FileType markdown setlocal formatexpr=
au FileType markdown setlocal formatprg=fold\ -w\ 79
" }
