
" nvim_lsp.clangd.setup({on_attach=on_attach_vim})

" lua << EOF
"     require'lspconfig'.texlab.setup{on_attach=require'completion'.on_attach}
"     require'lspconfig'.julials.setup{on_attach=require'completion'.on_attach}
"     require'lspconfig'.pylsp.setup{
"         on_attach=require'completion'.on_attach,
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
"                         ignore = { "E501", "E241", "E221", "E302", "E251", "E265" },
"                     },
"                     pydocstyle = {
"                         enabled = false,
"                     },
"                     pyflakes = { enabled = true },
"                     pylint = { enabled = true },
"                     rope_completion = { enabled = true },
"                     black = { enabled = true },
"                 }
"             }
"         }
"     }
" EOF

" lua << EOF
"     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
"         vim.lsp.diagnostic.on_publish_diagnostics, {
"             -- This will disable virtual text, like doing:
"             -- let g:diagnostic_enable_virtual_text = 0
"             virtual_text = false,
"             underline= false,
"
"             -- This is similar to:
"             -- let g:diagnostic_show_sign = 1
"             -- To configure sign display,
"             --  see: ":help vim.lsp.diagnostic.set_signs()"
"             signs = true,
"
"             -- This is similar to:
"             -- "let g:diagnostic_insert_delay = 1"
"             update_in_insert = false,
"         }
"     )
" EOF


" Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()
" autocmd Filetype julia  setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd FileType python setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd FileType tex    setlocal omnifunc=v:lua.vim.lsp.omnifunc
" autocmd FileType c,cpp,objc,objcpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

" let g:completion_enable_auto_popup = 1
" let g:completion_docked_hover = 1
" let g:completion_timer_cycle = 100 "default value is 80
" let g:completion_auto_change_source = 1
" let g:completion_enable_snippet = 'UltiSnips'
" let g:completion_enable_auto_signature = 0

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" set completeopt-=preview

" Avoid showing message extra message when using completion
set shortmess+=c

" imap <silent> <c-p> <Plug>(completion_trigger)
" nmap <tab> <Plug>(completion_smart_tab)
" nmap <s-tab> <Plug>(completion_smart_s_tab)

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"use <c-j> to switch to previous completion
" imap <C-j> <Plug>(completion_next_source)
"use <c-k> to switch to next completion
" imap <C-k> <Plug>(completion_prev_source)

" let g:completion_confirm_key = "\<C-y>"
" let g:completion_confirm_key = ""
" imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
"                  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

set completeopt=menu,menuone,noselect
set completeopt-=preview

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['texlab'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['julials'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
EOF






