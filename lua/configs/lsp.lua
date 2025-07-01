local M = {}

---- mason ----
M.mason = {
  --ensure_installed = { "lua-language-server"},  -- not an option from mason.nvim
  PATH = 'skip',

  ui = {
    icons = {
      package_pending = ' ',
      package_installed = '󰄳 ',
      package_uninstalled = ' 󰚌',
    },

    keymaps = {
      toggle_server_expand = '<CR>',
      install_server = 'i',
      update_server = 'u',
      check_server_version = 'c',
      update_all_servers = 'U',
      check_outdated_servers = 'C',
      uninstall_server = 'X',
      cancel_installation = '<C-c>',
    },
  },

  max_concurrent_installers = 10,
}

---- mason-lspconfig ----
M.mason_lspconfig = {
  automatic_installation = false,
  ensure_installed = {
    --'rust_analyzer', -- "rustfmt",
    --'pyright',
    --'clangd',
  },
}


---- lspconfig ----
M.lspconfig = function()
  local M = {}
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

  local servers = { 'rust_analyzer', 'clangd', 'gopls', 'lua_ls', 'sqlls', 'nil_ls' }
  --, "pyright", 'nil_ls', "lua_ls"} -- "pylsp"

  for _, server in ipairs(servers) do
    require('lspconfig')[server].setup {
      on_attach = M.on_attach,
      capabilities = M.capabilities,
      silent = true,
    }
  end

  -- pyright
  require('lspconfig').pyright.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    silent = true,
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
  -- nil_ls 
  --require('lspconfig').nil_ls.setup {
  --  on_attach = M.on_attach,
  --  --autostart = true,
  --  capabilities = M.capabilities,
  --  --cmd = { vim.env.NIL_PATH or 'target/debug/nil' },
  --  settings = {
  --    ['nil'] = {
  --      testSetting = 42,
  --      formatting = {
  --        command = { "nixpkgs-fmt" },
  --      },
  --    },
  --  },
  --}



  return M
end

return M
