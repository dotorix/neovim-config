
local M = {}

M.render_markdown = {
  -- Useful context to have when evaluating values.
  -- | level    | the number of '#' in the heading marker         |
  -- | sections | for each level how deeply nested the heading is |

  -- heading icon & background
  heading = {
    enabled = true,
    width = 'full',
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    signs = { '󰫎 ' },
  },

  -- code block & inline code
  code = {
    enabled = true,
    width = 'block',
  },

  -- thematic break
  dash = {
    enabled = true,
  },

  -- list bullet
  bullet = {
    enabled = true,
  },

  -- checkbox state
  checkbox = {
    enabled = true,
  },

  -- block quote & callout
  quote = {
    enabled = true,
  },

  -- pipe table
  pipe_table = {
    enabled = true,
    style = 'normal', -- 'full' adds inconsistency between normal and input mode
    filler = '',
    alignment_indicator = '─', --'━',
    border = {
      '┌', '┬', '┐',
      '├', '┼', '┤',
      '└', '┴', '┘',
      '│', '─',
    },
  },

  --callout = {
  --      note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
  --}

  -- inline link icon
  link = {
    enabled = true,
  },

  -- sign
  sign = {
    enabled = true,
  },

  -- org-indent-mode.
  indent = {
    enabled = false,
  },
}

return M
