local null_ls = require 'null-ls'

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  --b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  --b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua.with {
    extra_args = {
      '--quote-style=AutoPreferSingle',
      '--collapse-simple-statement=Always',
--      '--collapse-simple-statement=ConditionalOnly',
      '--call-parentheses=None',
      '--indent-type=Spaces',
      '--indent-width=2',
      '--line-endings=Unix',
    },
  },

  -- C++
  b.formatting.clang_format,

  -- Rust
  b.formatting.rustfmt,

  -- Python: black, autopep8, yapf, isort
  b.formatting.black,

  -- json
  b.formatting.jq,

  --[[b.diagnostics.sqlfluff.with({
    extra_args = { "--dialect", "postgres" }, -- change to your dialect
  }),]]
  b.formatting.sqlfluff.with({
    extra_args = { "--dialect", "postgres" }, -- change to your dialect
  }),

  --[[b.formatting.pg_format.with({
    extra_args = {
      '-u','1', '-U','1', '-f','1', '-g'
    }
  }),]]
}

null_ls.setup {
  debug = true,
  sources = sources,
}
