" Plugin-specific settings
" Author: poscar

" Taglist {
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
" }
" Command-T {
set wildignore+=*.o,*.object
set wildignore+=.git
set wildignore+=vendor/rails/**
set wildignore+=vendor/bundle/**
set wildignore+=node_modules/**,npm-debug.log
set wildignore+=**/vendor/**
set wildignore+=*.png,*.jpg,*.gif
" }

" Syntastic {
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['javascript'],
                           \ 'passive_filetypes': ['java'] }
let g:syntastic_check_on_open=1 
let g:syntastic_auto_jump=1
let g:syntastic_enable_balloons=1
let g:syntastic_enable_signs=1
" }

" Sparkup {
au FileType html let g:sparkupExecuteMapping="--"
" }

" snipMate {
let g:snips_trigger_key='<tab>'
" }

" vim-LaTeX {
let g:tex_flavor='latex'
" }

" UltiSnips {
let g:UltiSnipsExpandTrigger=",,"
let g:UltiSnipsJumpForwardTrigger=",,"
let g:UltiSnipsJumpBackwardTrigger="<nop>"
" }

" vim-easymotion {
let g:EasyMotion_leader_key = '-'
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
" }

" Haskell mode {
au BufEnter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/chromium"
let g:ghc = "/usr/bin/ghc"
" }
