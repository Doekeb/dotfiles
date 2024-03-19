return {
  "tpope/vim-fugitive",
  config = function()
    -- require("fugitive").setup({})
    vim.api.nvim_create_user_command("Gmergesplit", function(opts)
      vim.cmd(":Gvdiffsplit!")
      vim.cmd(":wincmd J")
    end, {})
    vim.keymap.set("n", "<leader>G", "<cmd>G<cr>", { noremap = true, silent = true })
  end,
}
