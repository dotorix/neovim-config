local opt = vim.opt
local g = vim.g

-------------------------------------- options ------------------------------------------

opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = 'unnamedplus'
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = ' ' }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = 'a'

-- Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false

-- search
opt.hlsearch = false
opt.incsearch = true

-- disable nvim intro
opt.shortmess:append 'sI'

opt.scrolloff = 8
opt.signcolumn = 'yes'
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append '<>[]hl'

g.mapleader = ' '

--g.rust_recommended_style = false
g.python_recommended_style = false
g.cpp_recommemnded_style = false
-- disable some default providers
-- molten (jupyter client) requires python provider
for _, provider in ipairs { 'node', 'perl', 'ruby' } do
  g['loaded_' .. provider .. '_provider'] = 0
end

-- custom python3 provider
g.python3_host_prog = '/usr/bin/python3'
--g.loaded_python3_provider = 1


local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

--local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
--local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
-- Здесь я не добавляю ',.' и 'бю', чтобы впоследствии не было рекурсивного вызова комманды
--local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
--local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
--vim.opt.langmap = vim.fn.join({
--  escape(ru_shift) .. ';' .. escape(en_shift),
--  escape(ru) .. ';' .. escape(en),
--}, ',')
