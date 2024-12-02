return {
  -- "kristijanhusak/vim-dadbod-ui",
  "doekeb/vim-dadbod-ui",
  -- dir = "/home/doeke/Projects/vim-dadbod-ui",
  dependencies = {
    -- { "tpope/vim-dadbod", lazy = true },
    { "doekeb/vim-dadbod", lazy = true },
    -- { dir = "/home/doeke/Projects/vim-dadbod", lazy = true },
    -- { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    { "doekeb/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    -- { dir = "/home/doeke/Projects/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_show_database_icon = 1
    vim.g.db_ui_win_position = "right"
    vim.g.db_ui_execute_on_save = 0

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        vim.api.nvim_buf_set_keymap(
          0,
          "n",
          "<leader>ss",
          "<Plug>(DBUI_ExecuteQuery)",
          { noremap = true, silent = true }
        )
      end,
    })
  end,
}
