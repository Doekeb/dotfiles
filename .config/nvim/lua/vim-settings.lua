vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.g.python3_host_prog = "/usr/bin/python"

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ signs = false })
vim.g.mapleader = " "
-- vim.cmd.set("nnoremap <Space> <NOP>")

local map = require("utils").set_global_keymap

map("n", "<leader>|", "<cmd>belowright vnew<cr>", "split vertical")
map("n", "<leader>_", "<cmd>belowright new<cr>", "split horizontal")
map("n", "<A-h>", "<cmd>wincmd H<cr>", "split horizontal")
map("n", "<A-j>", "<cmd>wincmd J<cr>", "split horizontal")
map("n", "<A-k>", "<cmd>wincmd K<cr>", "split horizontal")
map("n", "<A-l>", "<cmd>wincmd L<cr>", "split horizontal")

map("n", "<leader>e", vim.diagnostic.open_float, "show [e]rrors")
map("n", "]e", vim.diagnostic.goto_next, "go to next [e]rror")
map("n", "[e", vim.diagnostic.goto_prev, "go to previous [e]rror")
map("n", "<leader>te", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end, "[t]oggle [e]rrors")

vim.opt.formatoptions = vim.opt.formatoptions - "t"

local colorcolumn = function()
  local cc = "+1"
  for i = 2, 256 do
    cc = cc .. ",+" .. i
  end
  return cc
end
vim.opt.colorcolumn = colorcolumn()

vim.filetype.add({ filename = { [".flake8"] = "dosini" } })
vim.filetype.add({ filename = { [".sqlfluff"] = "cfg" } })
