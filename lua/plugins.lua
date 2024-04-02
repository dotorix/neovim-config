local plugins = {
  -- helper libraries
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',

  -------- color themes --------
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  --[[{
    "folke/tokyonight.nvim",
    --lazy = false,
    priority = 1000,
    --opts = {},
  },]]
  -- language-specific mapping
  --[[{
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      require'langmapper'.setup {}
    end,
  }]]
  -- colorscheme customization
  --[[{
    "rktjmp/lush.nvim",
    opts = function()
      return require "configs.lush_nvim"
    end,
    config = function(_, opts)
      require("lush").setup(opts)
    end,
  },]]

  -------- lsp stuff --------
  {
    'williamboman/mason.nvim', -- lsp-servers manager
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog' },
    opts = function()
      return require'configs.mason'.options
    end,
    config = function(_, opts)
      require'mason'.setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      --[[vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed]]
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = function()
      return require'configs.mason'.lspconfig
    end,
    config = function(_, opts)
      require'mason-lspconfig'.setup(opts)
    end,
  },

  {
    'neovim/nvim-lspconfig',
    init = function()
      require'utils'.lazy_load 'nvim-lspconfig'
    end,
    config = function()
      require'configs.lspconfig'
    end,
    dependencies = {
      -- formatting & linting
      {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
          require'configs.null-ls'
        end,
      },
    },
  },

  {
    -- auto-completion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        -- snippet plugin
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function(_, opts)
          require'configs.others'.luasnip(opts)
        end,
      },
      -- cmp sources plugins
      {
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
      },
    },
    opts = function()
      return require'configs.cmp'
    end,
    --[[config = function(_, opts)
      require'cmp'.setup(opts)
    end,]]
  },

  -------- debugging stuff --------
  {
    'mfussenegger/nvim-dap',
    cmd = {
      'DapStepInto','DapStepOver','DapStepOut','DapContinue','DapTerminate','DapLoadLaunchJSON',
      'DapToggleBreakpoint','DapToggleRepl','DapSetLogLevel','DapShowLog','DapRestartFrame'
    },
    init = function()
      require'utils'.load_mappings'dap'
    end,
    config = function()
      require'configs.dap'
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    init = function()
      require'utils'.load_mappings'dapui'
    end,
    opts = function()
      return require'configs.dap-ui'.ui
    end,
  },

  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter'},
    cmd = {'DapVirtualTextEnable','DapVirtualTextDisable','DapVirtualTextForceRefresh','DapVirtualTextToggle'},
    init = function()
      require'utils'.load_mappings'dapvirtualtext'
    end,
    opts = function()
      return require'configs.dap-ui'.virtualtext
    end
  },


  -------- jupyter kernel integration --------
  {
    'benlubas/molten-nvim', -- fork of magma-nvim
    build = ":UpdateRemotePlugins",
    init = function()
      require'utils'.load_mappings'molten'
    end,
    config = function()
      --require'molten'
      --require'configs.molten_nvim'
    end
  },


  -------- navigation stuff --------

  {
    -- syntax parsed into tree -> highlighting
    -- ported from the Atom text editor
    'nvim-treesitter/nvim-treesitter',
    cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
    build = ':TSUpdate',
    init = function()
      require'utils'.lazy_load 'nvim-treesitter'
    end,
    opts = function()
      return require'configs.treesitter'
    end,
    config = function(_, opts)
      require'nvim-treesitter.configs'.setup(opts)
    end,
  },

  {
    -- fuzzy finder
    'nvim-telescope/telescope.nvim',
    --dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = 'Telescope',
    init = function()
      require'utils'.load_mappings'telescope'
    end,
    opts = function()
      return require'configs.telescope'
    end,
    config = function(_, opts)
      local telescope = require'telescope'
      telescope.setup(opts)
      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  {
    -- GIGACHAD navigation plugin
    'ThePrimeagen/harpoon',
    init = function()
      require'utils'.load_mappings'harpoon'
    end,
    opts = function()
      return require'configs.harpoon'
    end,
    config = function(_, opts)
      require'harpoon'.setup(opts)
    end,
  },

  ---- status lines ----
  {
    'nvim-lualine/lualine.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    lazy = false,
    opts = function()
      return require'configs.lualine'
    end,
    --[[config = function(_, opts)
      require'lualine'.setup(opts)
    end,]]
  },

  --[[{ -- not using it
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = function()
      return require "configs.bufferline"
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },]]

  {
    -- just the sidebar fs tree
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    init = function()
      require'utils'.load_mappings'nvimtree'
    end,
    opts = function()
      return require'configs.nvimtree'
    end,
    --[[config = function(_, opts)
      --dofile(vim.g.base46_cache .. "nvimtree")
      require'nvim-tree'.setup(opts)
      --vim.g.nvimtree_side = opts.view.side
    end,]]
  },

  -- Only load whichkey after all the gui
  {
    'folke/which-key.nvim',
    keys = { '<leader>', '"', "'", '`', 'c', 'v', 'g' },
    init = function()
      require'utils'.load_mappings 'whichkey'
    end,
    config = function(_, opts)
      --dofile(vim.g.base46_cache .. "whichkey")
      require'which-key'.setup(opts)
    end,
  },
}

require'lazy'.setup(plugins, require'configs.lazy_nvim')
