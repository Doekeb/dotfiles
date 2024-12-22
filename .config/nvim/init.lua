-- Lazy Package Manager
require("vim-settings")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.look" },
    { import = "plugins.treesitter" },
    { import = "plugins.language" },
    { import = "plugins.git" },
    { import = "plugins" },
  },
  ui = { border = "rounded", backdrop = 100 },
})
