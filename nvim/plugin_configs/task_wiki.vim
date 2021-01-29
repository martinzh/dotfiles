
autocmd FileType vimwiki setlocal textwidth=100
autocmd FileType vimwiki setlocal colorcolumn=105

let g:task_rc_override = 'rc.defaultheight=0'

let tlatelab = {}
let tlatelab.path = "~/vimwiki/tlatelab"
let tlatelab.syntax = 'markdown'
let tlatelab.index = 'diary'
let tlatelab.ext = '.md'

let fcp_data = {}
let fcp_data.path = "~/Google\ Drive\ File\ Stream/Shared\ Drives/SportsAnalytics/PachucaGolStats/notas_datos"
let fcp_data.syntax = 'markdown'
let fcp_data.index = 'fcp_data'
let fcp_data.ext = '.md'

let g:vimwiki_list = [tlatelab, fcp_data]

let g:taskwiki_markup_syntax="markdown"
nnoremap <Leader>td :TaskWikiDone<CR>

