local M = {}

M.font_increase = function()
  local size = tonumber(vim.o.guifont:match("%d+"))
  vim.o.guifont = vim.o.guifont:gsub("%d+", new_size+1)
end

M.font_decrease = function()
  print(vim.o.guifont)
  local size = tonumber(vim.o.guifont:match("%d+"))
  vim.o.guifont = vim.o.guifont:gsub("%d+", new_size-1)
end

M.init = function()
  vim.g.guifont = "FiraCode Nerd Font Mono:h14"
  require("utils").load_mappings "neovide"

  vim.opt.linespace = 0
  
  vim.g.neovide_refresh_rate = 165
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_no_idle = false
  vim.g.neovide_confirm_quit = false
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_profiler = false

  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.05

  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_unfocused_outline_width = 0.125

  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_underline_automatic_scaling = false
  --vim.g.neovide_theme = 'auto'
  --vim.g.neovide_transparency = 0.0
  --vim.g.transparency = 0.8
  --vim.g.neovide_background_color = "#0f1117" .. alpha()
end

return M
