-- return {
--   "linux-cultist/venv-selector.nvim",
--   dependencies = {
--     "neovim/nvim-lspconfig",
--     "mfussenegger/nvim-dap",
--     "mfussenegger/nvim-dap-python", --optional
--     { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
--   },
--   lazy = false,
--   branch = "regexp", -- This is the regexp branch, use this for the new version
--   config = function()
--     require("venv-selector").setup()
--   end,
--   keys = {
--     { "<leader>vs", "<cmd>VenvSelect<cr>" },
--     { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
--   },
-- }
return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
  config = function()
    require("venv-selector").setup({
      name = { "venv", ".venv", "env" }, -- Remove "env" eventually
      changed_venv_hooks = {
        require("venv-selector").hooks.basedpyright,
      },
    })
    vim.api.nvim_create_autocmd("VimEnter", { command = "VenvSelectCached" })
  end,
  event = "VeryLazy",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
