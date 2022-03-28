
" Emmet vim config 

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
autocmd FileType html,css,javascript :set foldmarker=/##,##/
" let g:user_emmet_leader_key=','

lua << EOF
require'lspconfig'.tsserver.setup{}
EOF
