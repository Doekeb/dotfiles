return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    local detail = false
    oil.setup({
      columns = { "icon" },
      float = {
        preview_split = "right",
        max_width = 200,
      },
      preview = { max_width = { 100, 0.8 } },
      keymaps = {
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              oil.set_columns({ "icon", "permissions", "size", "mtime" })
            else
              oil.set_columns({ "icon" })
            end
          end,
        },
      },
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilEnter",
      callback = function()
        vim.print("here")
        oil.open_preview()
      end,
      -- callback = vim.schedule_wrap(function(args)
      --   if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      --     oil.open_preview()
      --   end
      -- end),
    })
    vim.keymap.set("n", "<C-n>", oil.toggle_float, { noremap = true })
  end,
}
