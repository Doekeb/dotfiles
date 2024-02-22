return { "benlubas/molten-nvim",
  --version = "^1.0.0",
  branch = "feat/history",
  build = "<Cmd>UpdateRemotePlugins",
  init = function()
    vim.g.molten_output_win_max_height = 12
  end,
}
