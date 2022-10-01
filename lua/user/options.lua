-- vim:set ts=2 sts=2 sw=2 et:
local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  completeopt = { "menuone", "noselect", },
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  showtabline = 2,
  smartcase = true,
  smartindent = true,
  swapfile = false,
  termguicolors = true,
  splitbelow = true,
  splitright = true,
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  cursorline = true,
  number = true,
  relativenumber = false,
  numberwidth = 4,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
}

vim.opt.shortmess:append "c"
vim.opt.iskeyword:remove "_"
vim.opt.whichwrap:prepend "<,>,[,],h,l"

for k, v in pairs(options) do
  vim.opt[k] = v
end
