vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 99999

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ signs = false })
-- vim.cmd.set("nnoremap <Space> <NOP>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>|", "<cmd>belowright vnew<cr>")
vim.keymap.set("n", "<leader>_", "<cmd>belowright new<cr>")
