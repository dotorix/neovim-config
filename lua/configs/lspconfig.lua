local M = {}

local servers = { 'rust_analyzer', 'clangd', 'lua_ls', 'sqlls', 'nil_ls' } --, "pyright", "lua_ls"} -- "pylsp"

-- support for mason.nvim
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
--vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (vim.fn.has("win32") and ";" or ":") .. vim.env.PATH

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  require('utils').load_mappings('lspconfig', { buffer = bufnr })

  if client.supports_method 'textDocument/semanticTokens' then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }
end

-- pyright
require('lspconfig').pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        useLibraryCodeForTypes = true,
      },
    },
  },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = false,
}

return M
