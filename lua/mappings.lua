-- n, v, i, t = mode names

local M = {}

--[[-- all possible variants
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
}]]



M.general = {

  -- from theprimeagen, https://youtu.be/w7i4amO_zaE?t=1464
  {"v",
    ["J"] = {":m '>+1<CR>gv=gv", "Move selected text down"},
    ["K"] = {":m '<-2<CR>gv=gv", "Move selected text up"},
    ["<Tab>"] = {">gv", "Increase indentation of selected text"},
    ["<S-Tab>"] = {"<gv", "Decrease indentation of selected text"}
  },

  nvi = {
    ["<M-a>"] = {"<cmd> bprev  <CR>", "prev buffer"},
    ["<M-d>"] = {"<cmd> bnext  <CR>", "next buffer"},
    ["<M-[>"] = {"<cmd> tabprev  <CR>", "prev tab"},
    ["<M-]>"] = {"<cmd> tabnext  <CR>", "next tab"},
  },

  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },


  n = {
    -- new ...
    ["<leader>nb"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>nt"] = { "<cmd> tabnew <CR>", "New tab" },
    ["<leader>nv"] = { "<cmd> vsplit <CR>", "New vertical split" },
    ["<leader>nh"] = { "<cmd> split <CR>", "New horizontal split" },
    ["<Esc>"] = { ":noh <CR>", "Clear highlights" },    

    -- switch between windows
    --["H"] = { "<C-w>h", "Window left" },
    --["L"] = { "<C-w>l", "Window right" },
    --["J"] = { "<C-w>j", "Window down" },
    --["K"] = { "<C-w>k", "Window up" },
    ["c"] = { "<cmd> q <CR>", "Window close" },

    -- save
    --["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    --["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers 
    ["<leader>nl"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>nr"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },


    
    --["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "LSP formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.neovide = {
  plugin = true, -- do not load automatically
  invtx = {
    ["<C-="] = {
      function()
        require("neovide").font_increase()
      end
    },
    ["<C--"] = {
      function()
        require("neovide").font_decrease()
      end
    },
  },
  nv = {
    ["<C-v>"] = {'"+P',"Paste"}
  },
  {"i","<C-v",'<ESC>"+Pi',"Paste"}
}

M.harpoon = {
  nv = {
    ["<leader>a"] = { function() require("harpoon.mark").add_file() end, "Harpoon the file" },
    ["<leader>h"] = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon menu" },
  },
  nvi = {
    ["<M-1>"] = { function() require("harpoon.ui").nav_file(1) end, "mark1" },
    ["<M-2>"] = { function() require("harpoon.ui").nav_file(2) end, "mark2" },
    ["<M-3>"] = { function() require("harpoon.ui").nav_file(3) end, "mark3" },
    ["<M-4>"] = { function() require("harpoon.ui").nav_file(4) end, "mark4" },
    ["<M-q>"] = { function() require("harpoon.ui").nav_prev() end, "prev mark" }, 
    ["<M-e>"] = { function() require("harpoon.ui").nav_next() end, "next mark" },
  }
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "LSP references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

return M
