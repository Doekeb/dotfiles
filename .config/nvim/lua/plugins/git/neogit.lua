return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
  },
  config = function()
    require("neogit").setup({ kind = "split_above" })
    vim.api.nvim_create_user_command("NG", "Neogit", {})
  end,
}
