return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  lazy = false,
  branch = "regexp",
  config = function()
    require("venv-selector").setup({
      name = { "venv", ".venv", "env" }, -- Remove "env" eventually
    })
  end,
  keys = { { "<leader>vs", "<cmd>VenvSelect<cr>" } },
}
