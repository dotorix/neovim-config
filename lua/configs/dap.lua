local M = {}

M.dap = function()
  local dap = require 'dap'

  -- gdb
  dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '-i', 'dap' },
  }
  -- lldb-vscode
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode',
    name = "'",
  }
  -- vscode-cpptools
  dap.adapters.cppdbg = {
    type = 'executable',
    --command = '<path-to-OpenDebugAD7>',
    command = '/home/admin/.vscode/extensions/ms-vscode.cpptools-1.17.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
    id = 'cppdbg',
  }

  dap.configurations.cpp = {
    {
      type = 'cppdbg',
      name = 'Launch',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},

      -- 💀
      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      -- runInTerminal = false,

    }
  }
end

M.dap_ui = {
  controls = {
    element = 'repl',
    enabled = true,
    icons = {
      disconnect = '',
      pause = '',
      play = '',
      run_last = '',
      step_back = '',
      step_into = '',
      step_out = '',
      step_over = '',
      terminate = '',
    },
  },
  element_mappings = {},
  expand_lines = true,
  floating = {
    border = 'single',
    mappings = {
      close = { 'q', '<Esc>' },
    },
  },
  force_buffers = true,
  icons = {
    collapsed = '',
    current_frame = '',
    expanded = '',
  },
  layouts = {
    { position = 'left',size = 40,
      elements = {
        { size = 0.25, id = 'scopes' },
        { size = 0.25, id = 'breakpoints' },
        { size = 0.25, id = 'stacks' },
        { size = 0.25, id = 'watches' },
      },
    },
    { position = 'bottom', size = 10,
      elements = {
        { size = 0.5, id = 'repl' },
        { size = 0.5, id = 'console' },
      },
    },
  },
  mappings = {
    edit = 'e',
    expand = { '<CR>', '<2-LeftMouse>' },
    open = 'o',
    remove = 'd',
    repl = 'r',
    toggle = 't',
  },
  render = { indent = 1, max_value_lines = 100 },
}

M.dap_ui_virtualtext = {
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- prefix virtual text with comment string
  only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
  all_references = false, -- show virtual text on all all references of the variable (not only definitions)
  clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
  --- A callback that determines how a variable is displayed or whether it should be omitted
  --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
  --- @param buf number
  --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
  --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
  --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
  --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
  virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

  -- experimental features:
  all_frames = false,
  virt_lines = false,
  virt_text_win_col = nil,
}

return M
