return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>G", "<cmd>G<cr>", { noremap = true, silent = true })
  end,
}
