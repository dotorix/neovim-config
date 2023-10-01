local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(section, mapping_opt)
  --vim.schedule(function()
  local function set_section_map(section_values)
    if section_values.plugin then
      return
    end

    section_values.plugin = nil

    for key,items in pairs(section_values) do
      modes = type(key) == "string" and key or items[1]
      val   = type(key) == "string" and items[1] or items[2]
      items = type(val) ~= "string" and items
        or   (type(key) == "string" and {items} or {{opts = items.opts,unpack(items,2)}})
      for key, values in pairs(items) do
        if type(values) == "string" then goto continue1 end
        values = type(key) == "number" and values or {key, opts = values.opts, unpack(values)}
        opts = values.opts and values.opts or {}
        opts.desc = values[3]
        for mode in modes:gmatch(".") do
          vim.keymap.set(mode, values[1], values[2], opts)
        end
        ::continue1::
      end
    end
  end

  local mappings = require("mappings")

  if type(section) == "string" then
    mappings[section]["plugin"] = nil
    mappings = { mappings[section] }
  end

  for _, sect in pairs(mappings) do
    set_section_map(sect)
  end
  --end)
end


M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

return M