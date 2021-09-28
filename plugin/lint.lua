local lint = require('lint')
local linters = lint.linters

lint.linters_by_ft = {
  sh = { 'shellcheck' },
  zsh = { 'shellcheck' },
  bash = { 'shellcheck' },
}
