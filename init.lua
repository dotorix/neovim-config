require "core"


require("utils").load_mappings() --didn't fully get it

-- bootstrap lazy.nvim if needed
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  require("bootstrap").lazy(lazypath)
else
  vim.opt.rtp:prepend(lazypath)
  require "plugins"
end
--dofile(vim.g.base46_cache .. "defaults")

if vim.g.neovide then
  require("neovide").init()
end

vim.cmd('colorscheme onedark')

--[[local mappings_table = vim.api.nvim_get_keymap('')
for _, mapping in ipairs(mappings_table) do
  print(mapping.lhs,"->",mapping.rhs)
end]]