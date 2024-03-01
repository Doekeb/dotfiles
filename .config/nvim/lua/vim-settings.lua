vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.scrolloff = 30

-- This mostly works with scrolloff = 9999, just breaks telescope
-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 	callback = function()
-- 		vim.cmd.normal("zz")
-- 	end,
-- })

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ signs = false })
-- vim.cmd.set("nnoremap <Space> <NOP>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>|", "<cmd>belowright vnew<cr>")
vim.keymap.set("n", "<leader>_", "<cmd>belowright new<cr>")
