" vim: fdm=marker

" ============================================================================
"        _                                          _____
" _   __(_)___ ___  __________    _________  ____  / __(_)___ _
"| | / / / __ `__ \/ ___/ ___/   / ___/ __ \/ __ \/ /_/ / __ `/
"| |/ / / / / / / / /  / /__    / /__/ /_/ / / / / __/ / /_/ /
"|___/_/_/ /_/ /_/_/   \___/____\___/\____/_/ /_/_/ /_/\__, /
"                         /_____/                     /____/
"
"   /  |/  /__  /  / / / /
"  / /|_/ /  / /  / /_/ /
" / /  / /  / /__/ __  /
"/_/  /_/  /____/_/ /_/
"
" Author: Martin Zumaya, June 2020
"
" ============================================================================
" Neovim default {{{1
" ============================================================================
if 0 | endif

if &compatible
    set nocompatible
endif
"
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0

if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vimIsInTmux = 1
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
else
  let g:vimIsInTmux = 0
endif

" ============================================================================
" Plugins {{{1
" ============================================================================

call plug#begin('~/.local/share/nvim/plugged')

" Version Control
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" gives us lists of key bindings
Plug 'liuchengxu/vim-which-key'

" Colorschemes
Plug 'chuling/equinusocio-material.vim'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/forest-night'
Plug 'skbolton/embark'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'hardcoreplayers/oceanic-material'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }

" UI Layout
Plug 'ryanoasis/vim-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'macthecadillac/lightline-gitdiff'
Plug 'itchyny/lightline.vim'
Plug 'pacha/vem-tabline'

" Terminal
Plug 'kassio/neoterm'
Plug 'jpalardy/vim-slime'
" Plug 'ncm2/float-preview.nvim'

" Autocomplete
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'zchee/deoplete-jedi'
" Plug 'Shougo/deoplete-lsp'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" let g:deoplete#enable_at_startup=1

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'

" Language Server Protocol
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/completion-nvim'

" File manager
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Code Navigation
Plug 'myusuf3/numbers.vim'

" Writing
Plug 'machakann/vim-sandwich'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'chaoren/vim-wordmotion'
Plug 'justinmk/vim-sneak'
Plug 'luochen1990/rainbow'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'sbdchd/vim-shebang'
" Plug 'mattn/emmet-vim'

" Syntax
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
Plug 'octol/vim-cpp-enhanced-highlight'

" Tmux
if g:vimIsInTmux == 1
  Plug 'sainnhe/tmuxline.vim'
endif

" Tags
" Plug 'majutsushi/tagbar'

" Python related
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Julia related
Plug 'mroavi/vim-julia-cell'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'kdheepak/JuliaFormatter.vim'

" Taskwarrior and Wiki
Plug 'tbabej/taskwiki'
Plug 'blindFS/vim-taskwarrior'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'vimwiki/vimwiki', { 'as' : 'vimwiki', 'branch' : 'dev'}

call plug#end()

" ============================================================================
" Basic settings and maps {{{1
" ============================================================================

runtime macros/matchit.vim

syntax enable
filetype plugin indent on
filetype plugin on

set hidden
set autoread
set linebreak
set expandtab
set cursorline
set splitright
set noshowmode
set noswapfile
set is

set shell=zsh
set shiftwidth=4
set softtabstop=4
set textwidth=110
set colorcolumn=114

let g:highlightedyank_highlight_duration = 500

" Set up leader key
let mapleader = "\<Space>"
inoremap jk <ESC>

" Clear highlighted search
nmap <silent> ,/ :nohlsearch<CR>

" Substitute word in cursor
" nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Move visual selection
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Duplicate lines
nnoremap zj mzyyP`z
nnoremap zk mzyyP`zk

" Do not insert comments when opening a line from a commented one
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

nnoremap <Leader>uf :! bash ~/Code/MiscScripts/rsync_figs.sh<CR>

" ============================================================================
" Which Key {{{1
" ============================================================================

set timeoutlen=500

let g:mapleader = "\<Space>"
let g:maplocalleader = "\<Space>"
let g:which_key_map = {}
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey '<Space>'<CR>

" which key can't figure out the easy-motion mappings
" let g:which_key_map = {" ": 'easy motion (re-input to use)'}

" ============================================================================
" UI Config {{{1
" ============================================================================

set encoding=utf8
" set background=dark

" Don't let terminal override my vim settings
" set notermguicolors

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" let g:oceanic_material_transparent_background=1
" let g:oceanic_material_allow_bold=1
" let g:oceanic_material_allow_italic=1
" let g:oceanic_material_allow_uderline=1
" let g:oceanic_material_allow_udercurl=1
" let g:oceanic_material_allow_reverse=1
" colorscheme oceanic_material

" use the best vertsplit char
" set fillchars+=vert:│
" let g:equinusocio_material_style = 'darker'
" let g:equinusocio_material_bracket_improved = 1
" colorscheme equinusocio_material

" the configuration options should be placed before `colorscheme sonokai`
" let g:sonokai_enable_italic = 1
" let g:sonokai_style = 'andromeda'
" let g:sonokai_style = 'shusia'
" colorscheme sonokai

" let g:edge_enable_italic = 1
" let g:edge_style = 'neon'
" colorscheme edge

" let g:forest_night_enable_italic = 1
" colorscheme forest-night

" let g:neodark#background = '#202020'
" let g:neodark#use_custom_terminal_theme = 1
" colorscheme neodark

" let g:quantum_italics = 1
" let g:quantum_black = 1
" colorscheme quantum

let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
colorscheme onedark

" colorscheme embark
" colorscheme challenger_deep

" Indent line level indicators
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'enable': {'tabline': 0},
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
                \ ['gitbranch', 'gitstatus', 'readonly', 'filename', 'modified'] ]
    \ },
    \ 'component': {
        \ 'gitstatus': '%<%{lightline_gitdiff#get_status()}',
    \ },
    \ 'component_visible_condition': {
        \ 'gitstatus': 'lightline_gitdiff#get_status() !=# ""',
    \ },
    \ 'component_function': {
        \ 'gitbranch': 'FugitiveHead'
    \ },
\ }

let g:lightline_gitdiff#indicator_added = '▴'
let g:lightline_gitdiff#indicator_deleted = '▾'
let g:lightline_gitdiff#indicator_modified = '▸'
let g:lightline_gitdiff#min_winwidth = '70'

let g:vem_tabline_show=2
let g:vem_tabline_show_icon=1
let g:vem_tabline_multiwindow_mode=1
let g:vem_tabline_show_number='index'

highlight VemTablineTabSelected term=bold cterm=bold ctermfg=0 ctermbg=255 guifg=#242424 guibg=#ffffff gui=bold

nmap <leader>h <Plug>vem_move_buffer_left-
nmap <leader>l <Plug>vem_move_buffer_right-
nmap <leader>p <Plug>vem_prev_buffer-
nmap <leader>n <Plug>vem_next_buffer-

nnoremap <leader>1 :1tabnext<CR>
nnoremap <leader>2 :2tabnext<CR>
nnoremap <leader>3 :3tabnext<CR>

function! DeleteCurrentBuffer() abort
    let current_buffer = bufnr('%')
    let next_buffer = g:vem_tabline#tabline.get_replacement_buffer()
    try
        exec 'confirm ' . current_buffer . 'bdelete'
        if next_buffer != 0
            exec next_buffer . 'buffer'
        endif
    catch /E516:/
       " If the operation is cancelled, do nothing
    endtry
endfunction
nmap <leader>d :call DeleteCurrentBuffer()<CR>

let g:rainbow_conf = {
\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\	'guis': [''],
\	'cterms': [''],
\	'operators': '_,_',
\	'contains_prefix': 'TOP',
\	'parentheses_options': '',
\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\	'separately': {
\		'*': {},
\		'markdown': {
\			'parentheses_options': 'containedin=markdownCode contained',
\		},
\		'lisp': {
\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\		},
\		'haskell': {
\			'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
\		},
\		'ocaml': {
\			'parenthess': ['start=/(\ze[^*]/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\[|/ end=/|\]/ fold', 'start=/{/ end=/}/ fold'],
\		},
\		'julia': {
\			'parentheses_options': 'containedin=juliaConditionalBlock,juliaConditionalEIBlock,juliaConditionalEBlock,juliaForBlock,juliaFunctionBlock,juliaWhileBlock,juliaBeginBlock,juliaStructBlock,juliaMutableStructBlock,juliaLetBlock,juliaDoBlock,juliaModuleBlock,juliaExceptionBlock,juliaCatchBlock,juliaFinallyBlock',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
\		},
\		'tex': {
\			'parentheses_options': 'containedin=texDocZone',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\		},
\		'vim': {
\			'parentheses_options': 'containedin=vimFuncBody,vimExecute',
\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold'],
\		},
\		'xml': {
\			'syn_name_prefix': 'xmlRainbow',
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'xhtml': {
\			'parentheses': ['start=/\v\<\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'))?)*\>/ end=#</\z1># fold'],
\		},
\		'html': {
\			'parentheses': ['start=/\v\<((script|style|area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\		},
\		'perl': {
\			'syn_name_prefix': 'perlBlockFoldRainbow',
\		},
\		'php': {
\			'syn_name_prefix': 'phpBlockRainbow',
\			'contains_prefix': '',
\			'parentheses': ['start=/(/ end=/)/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\[/ end=/\]/ containedin=@htmlPreproc contains=@phpClTop', 'start=/{/ end=/}/ containedin=@htmlPreproc contains=@phpClTop', 'start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold contains_prefix=TOP'],
\		},
\		'stylus': {
\			'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
\		},
\		'css': 0,
\		'sh': 0,
\	}
\}

" ============================================================================
" NERDTree {{{1
" ============================================================================

" autocmd vimenter * if !argc() | NERDTree | endif
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=50
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! nmap <C-\> :NERDTreeFocus<CR>

" ============================================================================

" CPP Config {{{1
" ============================================================================

let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1

" ============================================================================
" NERDcommenter {{{1
" ============================================================================

" Add a space between comment delimiter and comment
let g:NERDSpaceDelims = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" ============================================================================
" Snippets {{{1
" ============================================================================

let g:UltiSnipsExpandTrigger='<tab>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" ============================================================================
" EasyAlign {{{1
" ============================================================================

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ============================================================================
" Whitespace {{{1
" ============================================================================

let g:current_line_whitespace_disabled_soft=1
let g:better_whitespace_enabled=1
let g:better_whitespace_operator='_s'
let g:better_whitespace_skip_empty_lines=1
" let g:strip_whitespace_on_save=1

" nnoremap ]w :NextTrailingWhitespace<CR>
" nnoremap [w :PrevTrailingWhitespace<CR>

" ============================================================================
" Easymotion {{{1
" ============================================================================

highlight Sneak      guifg=white guibg=green  ctermfg=white ctermbg=green
highlight SneakScope guifg=red   guibg=yellow ctermfg=red   ctermbg=yellow

let g:sneak#label = 1

map s <Plug>Sneak_s
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ============================================================================
" Wordmotion {{{1
" ============================================================================

let g:wordmotion_prefix = ','

" ============================================================================
" Sandwich {{{1
" ============================================================================

runtime macros/sandwich/keymap/surround.vim

let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)

xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)

xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

xmap im <Plug>(textobj-sandwich-literal-query-i)
xmap am <Plug>(textobj-sandwich-literal-query-a)
omap im <Plug>(textobj-sandwich-literal-query-i)
omap am <Plug>(textobj-sandwich-literal-query-a)

" ============================================================================
" Autopairs {{{1
" ============================================================================

let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<A-b>'

" ============================================================================
" TaskWiki and VimWiki {{{1
" ============================================================================

autocmd FileType vimwiki setlocal textwidth=100
autocmd FileType vimwiki setlocal colorcolumn=105

let g:task_rc_override = 'rc.defaultheight=0'

let wiki_1 = {}
let wiki_1 = {}
let wiki_1.path = "~/vimwiki/"
let wiki_1.syntax = 'markdown'
let wiki_1.index = 'index'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = "~/vimwiki/diary"
let wiki_2.syntax = 'markdown'
let wiki_2.index = 'diary'
let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2]

let g:taskwiki_markup_syntax="markdown"
nnoremap <Leader>td :TaskWikiDone<CR>

" ============================================================================
" Version Control {{{1
" ============================================================================

set updatetime=30

let g:signify_sign_add = '▴'
let g:signify_sign_delete = '▾'
let g:signify_sign_delete_first_line = '▪'
let g:signify_sign_change = '▸'

let g:signify_sign_show_count = 0

let g:NERDTreeGitStatusShowIgnored=1
let g:NERDTreeGitIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" ============================================================================
" FZF {{{1
" ============================================================================

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
map <leader>bl :BLines<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

" Always enable preview window on the right with 60% width
" let g:fzf_preview_window = 'right:60%'

" Border color
" let g:fzf_layout = {
"     \ 'up':'~90%',
"     \ 'window': {
"     \ 'width': 0.8,
"     \ 'height': 0.8,
"     \ 'yoffset':0.5,
"     \ 'xoffset': 0.5,
"     \ 'highlight': 'Todo',
"     \ 'border': 'sharp' }
"     \ }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
" let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
" let g:fzf_colors = {
"   \ 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword',
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command  = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ============================================================================
" Autocomplete {{{1
" ============================================================================

lua << EOF
    local nvim_lsp = require'nvim_lsp'
    local on_attach_vim = function()
        require'diagnostic'.on_attach()
        require'completion'.on_attach()
    end
    nvim_lsp.texlab.setup({on_attach=on_attach_vim})
    nvim_lsp.julials.setup({on_attach=on_attach_vim})
    nvim_lsp.pyls.setup{
        on_attach=require'diagnostic'.on_attach,
        settings = {
            pyls = {
                configurationSources = {
                    pycodestyle,
                    flake8
                },
                plugins = {
                    mccabe = { enabled = false },
                    preload = { enabled = true },
                    pycodestyle = {
                        enabled = true,
                        ignore = { "E501" },
                    },
                    pydocstyle = {
                        enabled = false,
                    },
                    pyflakes = { enabled = true },
                    pylint = { enabled = false },
                    rope_completion = { enabled = true },
                    black = { enabled = false },
                }
            }
        }
    }
EOF

" lua << EOF
"     local nvim_lsp = require'nvim_lsp'
"     local on_attach_vim = function()
"         require'diagnostic'.on_attach()
"     end
"     nvim_lsp.texlab.setup({on_attach=on_attach_vim})
"     nvim_lsp.julials.setup({on_attach=on_attach_vim})
"     nvim_lsp.pyls.setup{
"         on_attach=require'diagnostic'.on_attach,
"         settings = {
"             pyls = {
"                 configurationSources = {
"                     pycodestyle,
"                     flake8
"                 },
"                 plugins = {
"                     mccabe = { enabled = false },
"                     preload = { enabled = true },
"                     pycodestyle = {
"                         enabled = true,
"                         ignore = { "E501" },
"                     },
"                     pydocstyle = {
"                         enabled = false,
"                     },
"                     pyflakes = { enabled = true },
"                     pylint = { enabled = false },
"                     rope_completion = { enabled = true },
"                     black = { enabled = false },
"                 }
"             }
"         }
"     }
" EOF

" Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
autocmd Filetype julia setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType python setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType tex setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd FileType c,cpp,objc,objcpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

let g:diagnostic_enable_underline = 0
let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_auto_popup_while_jump = 0
" let g:diagnostic_insert_delay = 1
" let g:diagnostic_trimmed_virtual_text = '20'

let g:completion_timer_cycle = 100 "default value is 80
let g:completion_auto_change_source = 1
let g:completion_enable_snippet = 'UltiSnips'

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" let g:completion_confirm_key = "\<C-y>"
" let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

" Preview
set completeopt-=preview
" let g:float_preview#docked = 0
" let g:float_preview#max_width = 100

function! DisableExtras()
  call nvim_win_set_option(g:float_preview#win, 'number',         v:false)
  call nvim_win_set_option(g:float_preview#win, 'cursorline',     v:false)
  call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
endfunction

autocmd User FloatPreviewWinOpen call DisableExtras()

" ============================================================================
" Terminal {{{1
" ============================================================================

" Where should the terminal open
let g:neoterm_default_mod = ':vertical'
let g:neoterm_keep_term_open = 1
let g:neoterm_autoscroll=1

" Commands to deal with the terminal
nnoremap <silent> <leader>to :Topen<CR>
nnoremap <silent> <leader>tc :Tclose<CR>
nnoremap <silent> <leader>tt :Ttoggle<CR>
nnoremap <silent> <leader>tk :Tkill<CR>
nnoremap <silent> <leader>tl :Tclear<CR>
nnoremap <silent> <leader>ts :T %:p<CR>
nnoremap <silent> <leader>tp :T python %:p<CR>
nnoremap <silent> <leader>tj :T julia<CR>

" silent! nmap <C-l> :TREPLSendLine<CR>
" silent! vmap <C-s> :TREPLSendSelection<CR>

" Easily change from insert to normal mode on a terminal
tnoremap <Esc> <C-\><C-n>

" ============================================================================
" Tmux {{{1
" ============================================================================

"tmuxline.vim
if g:vimIsInTmux == 1
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : [ '#[fg=blue]\Ufa51#{upload_speed} #[fg=blue]\uf6d9 #{download_speed}' ],
        \'c'    : [ "\#{sysstat_mem} #{sysstat_cpu}" ],
        \'win'  : [ '#I', '#W' ],
        \'cwin' : [ '#I', '#W', '#F' ],
        \'x'    : 'Batt: #{battery_icon} #{battery_color_bg}#{battery_percentage}#[default]',
        \'y'    : '#(date)',
        \'z'    : [ '#(whoami)', '#h #{prefix_highlight}' ]
        \}
  let g:tmuxline_separators = {
        \ 'left' : "\Ue0bc",
        \ 'left_alt': "\Ue0bd",
        \ 'right' : "\ue0ba",
        \ 'right_alt' : "\Ue0bd",
        \ 'space' : ' '}
endif

" ============================================================================
" Python Related {{{1
" ============================================================================

autocmd BufNewFile,BufRead *.py
    \set filetype=python
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set expandtab
    \set autoindent
    \set fileformat=unix
    \set textwidth=92
    \set colorcolumn=93
    
let g:python_highlight_all = 1
autocmd FileType python let g:slime_cell_delimiter = "# %"

let g:ipython_cell_delimit_cells_by = 'tags'
" fix paste issues in ipython
let g:slime_python_ipython = 1

autocmd FileType python nnoremap <Leader>jl :IPythonCellClear<CR>
autocmd FileType python nnoremap <Leader>jp :IPythonCellPrevCell<CR>
autocmd FileType python nnoremap <Leader>jn :IPythonCellNextCell<CR>
autocmd FileType python nnoremap <Leader>jx :IPythonCellClose<CR>

" ============================================================================
" Julia Related {{{1
" ============================================================================

" fix Julia highlighting
autocmd BufRead,BufNewFile *.jl set filetype=julia

autocmd FileType julia setlocal textwidth=92
autocmd FileType julia setlocal colorcolumn=93

autocmd FileType julia let g:slime_cell_delimiter = "##"
let g:julia_cell_delimit_cells_by = 'tags' " Use '##' tags to define cells

" let g:latex_to_unicode_keymap = 1

" map <Leader>jr to run entire file
" nnoremap <Leader>jr :JuliaCellRun<CR>
autocmd FileType julia nnoremap <Leader>jl :JuliaCellClear<CR>
autocmd FileType julia nnoremap <Leader>jp :JuliaCellPrevCell<CR>
autocmd FileType julia nnoremap <Leader>jn :JuliaCellNextCell<CR>

" map <Leader>jc to execute the current cell
" nnoremap <Leader>jc :JuliaCellExecuteCell<CR>
" map <Leader>jC to execute the current cell and jump to the next cell
" nnoremap <Leader>jC :JuliaCellExecuteCellJump<CR>

" let g:slime_target = 'neovim'
let g:slime_target = 'tmux'
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_dont_ask_default = 1

nmap <Leader>js <Plug>SlimeLineSend
xmap <Leader>js <Plug>SlimeRegionSend
nmap <Leader>jc <Plug>SlimeSendCell

" Clears jlia REPL
nmap <C-l> :silent !tmux send-keys -t "{right-of}" C-l <cr>

let g:JuliaFormatter_options = {
        \ 'indent'                    : 4,
        \ 'margin'                    : 92,
        \ 'always_for_in'             : v:true,
        \ 'whitespace_typedefs'       : v:false,
        \ 'whitespace_ops_in_indices' : v:true,
        \ }

" normal mode mapping
nnoremap <localleader>jf :<C-u>call JuliaFormatter#Format(0)<CR>
" visual mode mapping
vnoremap <localleader>jf :<C-u>call JuliaFormatter#Format(1)<CR>

" activate tagbar
" nmap <Leader>tb :TagbarToggle<CR>

" ctags config location
" let g:tagbar_ctags_options = ['NONE', $HOME.'/.config/ctags']

" tagbar for Julia
" let g:tagbar_type_julia = {
"     \ 'ctagstype' : 'julia',
"     \ 'kinds'     : [
"         \ 't:struct', 'f:function', 'm:macro', 'c:const']
"     \ }

" ============================================================================
" LaTeX {{{1
" ============================================================================

autocmd FileType tex setlocal textwidth=90
autocmd FileType tex setlocal colorcolumn=92

nnoremap <silent> <leader>lc :VimtexCompile<CR>
nnoremap <silent> <leader>lv :VimtexView<CR>
nnoremap <silent> <leader>lo :VimtexTocOpen<CR>
nnoremap <silent> <leader>lt :VimtexTocToggle<CR>

let g:vimtex_compiler_progname='nvr'
let g:vimtex_view_automatic = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:tex_conceal = ""

let g:tex_flavor = "pdflatex"
" let g:vimtex_compiler_engine='xelatex'
let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -interaction=nonstopmode $*'

" This is new style
" call deoplete#custom#var('omni', 'input_patterns', {
"             \ 'tex': g:vimtex#re#deoplete
"             \})

let g:vimtex_compiler_latexmk = {
         \ 'build_dir' : 'build',
         \}

" Skim config
let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_compiler_callback_hooks = ['UpdateSkim']

function! UpdateSkim(status)
    if !a:status | return | endif

    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']

    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif

    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescpe(l:out), shellescape(l:tex)], ' '))
    endif
endfunction

" ============================================================================
" Buffers {{{1
" ============================================================================

command! -nargs=+ Bs :vert sbuffer <args>

" nnoremap <C-D-<Down>>  <C-W><C-J>
" nnoremap <C-D-<Up>>    <C-W><C-K>
" nnoremap <C-D-<Right>> <C-W><C-L>
" nnoremap <C-D-<Left>>  <C-W><C-H>

" Commands to deal with the buffers without going all the way through the
" colon
nnoremap <silent> <leader>bn :bn<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>bp :bp<CR>
nnoremap <silent> <leader>ls :ls<CR>
nnoremap <silent> <leader>bs1 :Bs 1<CR>
nnoremap <silent> <leader>bs2 :Bs 2<CR>
nnoremap <silent> <leader>bs3 :Bs 3<CR>
nnoremap <silent> <leader>bs4 :Bs 4<CR>
nnoremap <silent> <leader>bs5 :Bs 5<CR>
