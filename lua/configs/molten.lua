local g = vim.g

-- the output doesn't cover anything while it's open
g.molten_output_virt_lines = true -- default=false

-- Allows the output window to cover exactly one line of the regular buffer when output_virt_lines is true
g.molten_virt_lines_off_by_1 = false -- default=false

-- virtual text stays after leaving the cell
g.molten_virt_text_output = false -- default=false 
g.molten_virt_text_max_lines = 16 -- default=12
