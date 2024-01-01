-- n, v, i, t = mode names

local M = {}

--[[-- all possible ways
M.example = {
  {"ni","<C-a>",'"+P',"Paste1"},
  ni = {"<C-b>",'"+P',"Paste2"},
  {"vn",{
    {"<C-c>",'"+P',"Paste3"},
    ["<C-d>"] = {'"+P',"Paste4"}
  }},
  iv = {
    {"<C-e>",'"+P',"Paste5"},
    ["<C-f>"] = {'"+P',"Paste6"}
  }
]]

M.general = {

  -- from theprimeagen, https://youtu.be/w7i4amO_zaE?t=1464
  {
    'v',
    ['J'] = { ":m '>+1<CR>gv=gv", 'Move selected text down' },
    ['K'] = { ":m '<-2<CR>gv=gv", 'Move selected text up' },
    ['<Tab>'] = { '>gv', 'Increase indentation of selected text' },
    ['<S-Tab>'] = { '<gv', 'Decrease indentation of selected text' },
    ['>'] = {'>gv', 'keep visual while > indenting'},
    ['<'] = {'<gv', 'keep visual while > indenting'}

  },

  nvi = {
    ['<M-a>'] = { '<cmd> bprev  <CR>', 'prev buffer' },
    ['<M-d>'] = { '<cmd> bnext  <CR>', 'next buffer' },
    ['<M-[>'] = { '<cmd> tabprev  <CR>', 'prev tab' },
    ['<M-]>'] = { '<cmd> tabnext  <CR>', 'next tab' },
    ['<C-left>'] = { '<C-w>h', 'window left' },
    ['<C-right>'] = { '<C-w>l', 'window right' },
    ['<C-down>'] = { '<C-w>j', 'window down' },
    ['<C-up>'] = { '<C-w>k', 'window up' },
  },

  i = {
    -- go to  beginning and end
    ['<C-b>'] = { '<ESC>^i', 'Beginning of line' },
    ['<C-e>'] = { '<End>', 'End of line' },

    -- navigate within insert mode
    ['<C-h>'] = { '<left>', 'move left' },
    ['<C-l>'] = { '<right>', 'move right' },
    ['<C-j>'] = { '<down>', 'move down' },
    ['<C-k>'] = { '<up>', 'move up' },
  },

  n = {
    ['<C-h>'] = { '<C-w>h', 'window left' },
    ['<C-l>'] = { '<C-w>l', 'window right' },
    ['<C-j>'] = { '<C-w>j', 'window down' },
    ['<C-k>'] = { '<C-w>k', 'window up' },
    -- new ...
    ['<leader>nb'] = { '<cmd> enew <CR>', 'New buffer' },
    ['<leader>nt'] = { '<cmd> tabnew <CR>', 'New tab' },
    ['<leader>vs'] = { '<cmd> vsplit <CR>', 'New vertical split' },
    ['<leader>nh'] = { '<cmd> split <CR>', 'New horizontal split' },
    ['<Esc>'] = { ':noh <CR>', 'Clear highlights' },

    -- switch between windows
    --["H"] = { "<C-w>h", "Window left" },
    --["L"] = { "<C-w>l", "Window right" },
    --["J"] = { "<C-w>j", "Window down" },
    --["K"] = { "<C-w>k", "Window up" },
    ['c'] = { '<cmd> q <CR>', 'Window close' },

    -- save
    --["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    --["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ['<leader>nl'] = { '<cmd> set nu! <CR>', 'Toggle line number' },
    ['<leader>nr'] = { '<cmd> set rnu! <CR>', 'Toggle relative number' },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },

    --["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    ['<leader>fm'] = {
      function() vim.lsp.buf.format { async = true } end,
      'LSP formatting',
    },
  },

  t = {
    ['<C-x>'] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), 'Escape terminal mode' },
  },

  v = {
    ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
  },

  x = {
    ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ['p'] = { 'p:let @+=@0<CR>:let @"=@0<CR>', 'Dont copy replaced text', opts = { silent = true } },
  },
}

M.neovide = {
  lazy = true, -- do not load automatically
  invtx = {
    ['<C-='] = {
      function() require'neovide'.font_increase() end,
    },
    ['<C--'] = {
      function() require'neovide'.font_decrease() end,
    },
  },
  nv = {
    ['<C-v>'] = { '"+P', 'Paste' },
  },
  { 'i', '<C-v', '<ESC>"+Pi', 'Paste' },
}

M.harpoon = {
  lazy=true,
  nv = {
    ['<leader>a'] = { function() require'harpoon.mark'.add_file() end, 'Harpoon the file' },
    ['<leader>h'] = { function() require'harpoon.ui'.toggle_quick_menu() end, 'Harpoon menu' },
  },
  nvi = {
    ['<M-1>'] = { function() require'harpoon.ui'.nav_file(1) end, 'mark1' },
    ['<M-2>'] = { function() require'harpoon.ui'.nav_file(2) end, 'mark2' },
    ['<M-3>'] = { function() require'harpoon.ui'.nav_file(3) end, 'mark3' },
    ['<M-4>'] = { function() require'harpoon.ui'.nav_file(4) end, 'mark4' },
    ['<M-q>'] = { function() require'harpoon.ui'.nav_prev() end, 'prev mark' },
    ['<M-e>'] = { function() require'harpoon.ui'.nav_next() end, 'next mark' },
  },
}

M.lspconfig = {
  lazy = true,
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    ['gD'] = { vim.lsp.buf.declaration, 'LSP declaration' },
    ['gd'] = { vim.lsp.buf.definition, 'LSP definition' },
    ['K'] = { vim.lsp.buf.hover, 'LSP hover' },
    ['gi'] = { vim.lsp.buf.implementation, 'LSP implementation' },
    ['<leader>ls'] = { vim.lsp.buf.signature_help, 'LSP signature help' },
    ['<leader>D'] = { vim.lsp.buf.type_definition, 'LSP definition type' },
    ['<leader>ca'] = { vim.lsp.buf.code_action, 'LSP code action' },
    ['gr'] = { vim.lsp.buf.references, 'LSP references' },
    ['<leader>s'] = {
      function() vim.diagnostic.open_float { border = 'rounded' } end,
      'Floating diagnostic',
    },
    ['[d'] = { function() vim.diagnostic.goto_prev { float = { border = 'rounded' } } end, 'Goto prev' },
    [']d'] = { function() vim.diagnostic.goto_next { float = { border = 'rounded' } } end, 'Goto next' },
    ['<leader>q'] = { vim.diagnostic.setloclist, 'Diagnostic setloclist' },
    ['<leader>wa'] = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
    ['<leader>wr'] = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
    ['<leader>wl'] = {
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      'List workspace folders',
    },
  },
}

M.dap = {
  lazy = true,
  n = {
    ['<F1>'] = { function() require'dap'.step_into() end, 'Debug step into' },
    ['<F2>'] = { function() require'dap'.step_over() end, 'Debug step over' },
    ['<F3>'] = { function() require'dap'.step_out() end, 'Debug step out' },
    ['<F4>'] = { function() require'dap'.continue() end, 'Debug continue' },

    ['<leader>b'] = { function() require'dap'.toggle_breakpoint() end, 'Toggle breakpoint' },
    ['<leader>B'] = {
      function() require'dap'.set_breakpoint(vim.fn.input 'Condition: ') end,
      'Conditional breakpoint',
    },
    ['<leader>lp'] = {
      function() require'dap'.set_breakpoint(nil, nil, vim.fn.input 'Log message: ') end,
      'Log point',
    },
    ['<leader>dr'] = { function() require'dap'.repl.open() end, 'REPL open' },
  },
}
M.dapui = {
  lazy = true,
  n = {
    ['<F5>'] = { function() require'dapui'.toggle() end, 'Toggle dap-ui' },
  }
}
M.dapvirtualtext = {
  lazy = true,
  n = {
    ['<F6>'] = {'<cmd> DapVirtualTextToggle <CR>', 'Toggle dap-virtual-text' },
  }
}

M.molten = {
  lazy = true,
  v = {
    ['m'] = {'<cmd> MoltenEvaluateVisual <CR>', 'MoltenEvaluateVisual selection'}
  },
  n = {
    ['mm'] = {'<cmd> MoltenInit <CR>', 'MoltenInit' },
    ['mq'] = {'<cmd> MoltenInit <CR>', 'MoltenDeinit' },
    --['ms'] = {'<cmd> MoltenInit shared <CR>', 'MoltenInit shared' },
    ['ml'] = {'<cmd> MoltenEvaluateLine <CR>', 'MoltenEvaluateLine' }
  }
}

M.nvimtree = {
  lazy = true,
  n = {
    -- toggle
    ['<C-n>'] = { '<cmd> NvimTreeToggle <CR>', 'Toggle nvimtree' },
    -- focus
    ['<leader>e'] = { '<cmd> NvimTreeFocus <CR>', 'Focus nvimtree' },
  },
}

M.telescope = {
  lazy = true,
  n = {
    -- find
    ['<leader>ff'] = { function() require'telescope.builtin'.find_files() end, 'Find files' },
    ['<leader>fa'] = { function() require'telescope.builtin'.find_files { follow = true, no_ignore = true, hidden = true } end, 'Find all' },
    --['<leader>fa'] = { '<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>', 'Find all' },
    ['<leader>fw'] = { function() require'telescope.builtin'.live_grep() end, 'Live grep' },
    ['<leader>fb'] = { function() require'telescope.builtin'.buffers() end, 'Find buffers' },
    ['<leader>fh'] = { function() require'telescope.builtin'.help_tags() end, 'Help page' },
    ['<leader>fo'] = { function() require'telescope.builtin'.oldfiles() end, 'Find oldfiles' },
    ['<leader>fz'] = { function() require'telescope.builtin'.current_buffer_fuzzy_find() end, 'Find in current buffer' },
    --git
    ['<leader>cm'] = { function() require'telescope.builtin'.git_commits() end, 'Git commits' },
    ['<leader>gt'] = { function() require'telescope.builtin'.git_status() end, 'Git status' },

    ['<leader>ma'] = { function() require'telescope.builtin'.marks() end, 'Telescope bookmarks' },

  -- pick a hidden term
  --['<leader>pt'] = { '<cmd> Telescope terms <CR>', 'Pick hidden term' },

  -- theme switcher
  --['<leader>th'] = { '<cmd> Telescope themes <CR>', 'Nvchad themes' },
  },
}


M.whichkey = {
  lazy = true,
  n = {
    ['<leader>wK'] = {
      function() vim.cmd 'WhichKey' end,
      'Which-key all keymaps',
    },
    ['<leader>wk'] = {
      function()
        local input = vim.fn.input 'WhichKey: '
        vim.cmd('WhichKey ' .. input)
      end,
      'Which-key query lookup',
    },
  },
}

return M
