local keymap = vim.api.nvim_set_keymap
local expr_opts = { noremap = true, silent = true, expr = true }
local opts = { noremap = true, silent = true }

keymap(
    "i",
    "<c-j>",
    [[coc#pum#visible() ? coc#pum#next(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext', [])<cr>" : "\<c-j>"]]
    ,
    expr_opts
)
keymap(
    "i",
    "<c-k>",
    [[coc#pum#visible() ? coc#pum#prev(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev', [])<cr>" : "\<c-k>"]]
    ,
    expr_opts
)

-- add in the lspconfig for ruby

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

require'lspconfig'.solargraph.setup {
  flags = {
    debounce_text_changes = 150,
  }
}

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end
