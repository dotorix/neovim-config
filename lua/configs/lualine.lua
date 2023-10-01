local function show_tabs_condition()
  return vim.fn.tabpagenr('$') > 1
end

--[[
local hp_marks = require('harpoon.mark')
local devicons = require('nvim-web-devicons')
function Harpoon_files()
  local contents = {}

  for idx = 1, hp_marks.get_length() do
    local file_path = hp_marks.get_marked_file_name(idx)
    local file_name
    if file_path == "" then
      file_name = "(empty)"
    else
      file_name = vim.fn.fnamemodify(file_path, ':t')
    end
    local dev, _ = devicons.get_icon(file_name)

    local current_file_path = vim.fn.expand("%:f")

    local prev = ""
    if idx ~= 1 then
      prev = " "
    end
    local next = ""
    if idx < hp_marks.get_length() then
      next = " "
    end
    if file_path == current_file_path then
      contents[idx] = string.format("%%#lualine_b_normal#%s%s %s%s", prev, dev, file_name, next)
    else
      contents[idx] = string.format("%%#lualine_b_inactive#%s%s %s%s", prev, dev, file_name, next)
    end
  end

  return table.concat(contents)
end
]]

return {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '', -- { left = '', right = ''},
    section_separators = '', --{ left = '', right = ''},
    use_mode_colors = true,
    show_filename_only = false,
    unique_buffer_name = true,
    symbols = {
      modified = ' ●',      -- Text to show when the buffer is modified
      alternate_file = '',  -- Text to show to identify the alternate file
      directory =  '',     -- Text to show when the buffer is a directory
    },
    --[[disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }]]
  },
  sections = {
    lualine_a = {'buffers'}, --'filename',Harpoon_files}, -- 'buffers'}, --} },
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {},   --{'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },


--[[inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },]]
  
  tabline = {
    --lualine_c = {'filename', cond = show_tabs_condition}
  },
  --[[  --condition = require('lualine.utils.tabs').show_tabs_condition,
    lualine_a = {},
    lualine_b = {}, --{'branch'},
    lualine_c = {}, --{'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },]]
  --[[winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },]]
  extensions = {}
}

--[[Available components
  -- branch (git branch)
  -- buffers (shows currently available buffers)
  -- diagnostics (diagnostics count from your preferred source)
  -- diff (git diff status)
  -- encoding (file encoding)
  -- fileformat (file format)
  -- filename
  -- filesize
  -- filetype
  -- hostname
  -- location (location in file in line:column format)
  -- mode (vim mode)
  -- progress (%progress in file)
  -- searchcount (number of search matches when hlsearch is active)
  -- selectioncount (number of selected characters or lines)
  -- tabs (shows currently available tabs)
  -- windows (shows currently available windows)
]]
