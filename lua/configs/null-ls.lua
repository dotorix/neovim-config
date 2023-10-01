local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  --b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  --b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  --b.formatting.stylua,

  -- C++
  b.formatting.clang_format,

  -- Rust
  b.formatting.rustfmt,

  -- Python: black, autopep8, yapf, isort
  b.formatting.black,

}

null_ls.setup {
  debug = true,
  sources = sources,
}
