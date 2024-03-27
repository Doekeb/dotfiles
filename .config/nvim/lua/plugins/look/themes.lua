return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        overrides = function(colors)
          return {
            IlluminatedWordText = { link = "DiffText" },
            IlluminatedWordRead = { link = "DiffText" },
            IlluminatedWordWrite = { link = "DiffText" },
            ["@string.documentation"] = { fg = colors.theme.vcs.added },
          }
        end,
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },
      })
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
