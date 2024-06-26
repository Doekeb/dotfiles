vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.g.python3_host_prog = "/usr/bin/python"

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ signs = false })
-- vim.cmd.set("nnoremap <Space> <NOP>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>|", "<cmd>belowright vnew<cr>")
vim.keymap.set("n", "<leader>_", "<cmd>belowright new<cr>")
vim.keymap.set("n", "]e", vim.diagnostic.goto_next)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev)

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
