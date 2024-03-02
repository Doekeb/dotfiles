vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.scrolloff = 9999

-- This mostly works, but only in normal mode. Adding "CursorMovedI" breaks Telescope
vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	callback = function()
		vim.cmd.normal("zz")
	end,
})

vim.opt.signcolumn = "yes"
vim.diagnostic.config({ signs = false })
-- vim.cmd.set("nnoremap <Space> <NOP>")

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>|", "<cmd>belowright vnew<cr>")
vim.keymap.set("n", "<leader>_", "<cmd>belowright new<cr>")
