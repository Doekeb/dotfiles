local tbl_deep_copy
tbl_deep_copy = function(t)
  if type(t) ~= "table" then
    return t
  end
  local res = {}
  for k, v in pairs(t) do
    res[k] = tbl_deep_copy(v)
  end
  return res
end

return {
  -- "folke/snacks.nvim",
  "doekeb/snacks.nvim",
  -- dir = "/home/doeke/Projects/snacks.nvim",
  priority = 1000,
  lazy = false,
  config = function()
    local layouts = require("snacks.picker.config.layouts")

    local select_r = tbl_deep_copy(layouts.select)
    select_r["reverse"] = true
    select_r.layout[1], select_r.layout[2] = select_r.layout[2], select_r.layout[1]
    select_r.layout[2].border = "top"

    local dropdown_r = tbl_deep_copy(layouts.dropdown)
    dropdown_r["reverse"] = true
    dropdown_r.layout[2][1], dropdown_r.layout[2][2] = dropdown_r.layout[2][2], dropdown_r.layout[2][1]
    dropdown_r.layout[2][2].border = "top"

    local sidebar_r = tbl_deep_copy(layouts.sidebar)
    sidebar_r["reverse"] = true
    sidebar_r.layout[1], sidebar_r.layout[2] = sidebar_r.layout[2], sidebar_r.layout[1]

    local left_r = { preset = "sidebar_r" }
    local right_r = { preset = "sidebar_r", layout = { position = "right" } }

    require("snacks").setup({
      picker = {
        enabled = true,
        ui_select = true,
        layouts = {
          select_r = select_r,
          dropdown_r = dropdown_r,
          sidebar_r = sidebar_r,
          left_r = left_r,
          right_r = right_r,
        },
        layout = function()
          return vim.o.columns >= 120 and { preset = "telescope" } or { preset = "dropdown_r" }
        end,
        win = {
          input = {
            keys = {
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-f>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<c-b>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-d>"] = "preview_scroll_down",
              ["<c-u>"] = "preview_scroll_up",
              ["<c-f>"] = "preview_scroll_right",
              ["<c-b>"] = "preview_scroll_left",
            },
          },
        },
      },
    })
    -- TODO: How to deal with pickers that don't need a preview window
    vim.keymap.set("n", "<leader>ff", Snacks.picker.files, { desc = "[f]ind [f]iles" })
    vim.keymap.set("n", "<leader>fF", function()
      Snacks.picker.files({ hidden = true, ignored = true, follow = true })
    end, { desc = "[f]ind all [F]iles" })
    vim.keymap.set("n", "<leader>fif", Snacks.picker.grep, { desc = "[f]ind [i]n [f]iles" })
    vim.keymap.set("n", "<leader>fiF", function()
      Snacks.picker.grep({ hidden = true, ignored = true, follow = true })
    end, { desc = "[f]ind [i]n all [F]iles" })
    vim.keymap.set("n", "<leader>fb", Snacks.picker.buffers, { desc = "[f]ind [b]uffers" })
    vim.keymap.set("n", "<leader>fib", Snacks.picker.grep_buffers, { desc = "[f]ind [i]n [b]uffers" })
    -- vim.keymap.set("n", '<leader>f"', function()
    --   Snacks.picker.registers({ layout = { preset = "select", layout = { relative = "cursor" } } })
    -- end, { desc = '[f]ind registers ["]' })
    vim.keymap.set("n", '<leader>f"', Snacks.picker.registers, { desc = '[f]ind registers ["]' })
    vim.keymap.set("n", "<leader>f/", Snacks.picker.search_history, { desc = "[f]ind search history [/]" })
    vim.keymap.set("n", "<leader>f:", Snacks.picker.command_history, { desc = "[f]ind command history [:]" })
    vim.keymap.set("n", "<leader>fc", Snacks.picker.commands, { desc = "[f]ind [c]ommands" })
    vim.keymap.set("n", "<leader>fe", Snacks.picker.diagnostics_buffer, { desc = "[f]ind [e]rrors" })
    vim.keymap.set("n", "<leader>fE", Snacks.picker.diagnostics, { desc = "[f]ind all [E]rrors" })
    vim.keymap.set("n", "<leader>fh", Snacks.picker.help, { desc = "[f]ind [h]elp" })
    vim.keymap.set("n", "<leader>fj", Snacks.picker.jumps, { desc = "[f]ind [j]umps" })
    vim.keymap.set("n", "<leader>fp", Snacks.picker.projects, { desc = "[f]ind [p]rojects" })
    vim.keymap.set("n", "<leader>fu", Snacks.picker.undo, { desc = "[f]ind [u]ndo tree" })

    vim.keymap.set("n", "<leader>fgS", Snacks.picker.git_stash, { desc = "[f]ind [g]it [S]tash" })
    vim.keymap.set("n", "<leader>fgs", Snacks.picker.git_status, { desc = "[f]ind [g]it [s]tatus" })
    vim.keymap.set("n", "<leader>fgl", Snacks.picker.git_log_line, { desc = "[f]ind [g]it [l]ine commits" })
    vim.keymap.set("n", "<leader>fgf", Snacks.picker.git_log_file, { desc = "[f]ind [g]it [f]ile commits" })
    vim.keymap.set("n", "<leader>fgc", Snacks.picker.git_log, { desc = "[f]ind [g]it [c]ommits" })
  end,
}
