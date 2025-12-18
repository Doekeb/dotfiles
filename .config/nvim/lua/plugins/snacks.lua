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
    local snacks = require("snacks")
    local layouts = require("snacks.picker.config.layouts")
    local diffview = require("diffview")

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

    local ivy_r = tbl_deep_copy(layouts.ivy)
    ivy_r["reverse"] = true
    ivy_r.layout[1], ivy_r.layout[2] = ivy_r.layout[2], ivy_r.layout[1]
    ivy_r.layout[2].border = "top"

    local ivy_split_r = tbl_deep_copy(layouts.ivy_split)
    ivy_split_r["reverse"] = true
    ivy_split_r.layout[1], ivy_split_r.layout[2] = ivy_split_r.layout[2], ivy_split_r.layout[1]
    ivy_split_r.layout[2].border = "top"

    local ivy_r_no_preview = tbl_deep_copy(ivy_r)
    ivy_r_no_preview["hidden"] = { "preview" }

    local left_r = { preset = "sidebar_r" }
    local right_r = { preset = "sidebar_r", layout = { position = "right" } }

    local git_win = {
      input = {
        keys = { ["do"] = { "diffview_open", mode = { "n" } }, ["dO"] = { "diffview_open_full", mode = { "n" } } },
      },
    }
    local tmux_win = { input = { keys = { ["ss"] = { "slime_select", mode = { "n" } } } } }

    snacks.setup({
      picker = {
        enabled = true,
        ui_select = true,
        layouts = {
          select_r = select_r,
          dropdown_r = dropdown_r,
          sidebar_r = sidebar_r,
          left_r = left_r,
          right_r = right_r,
          ivy_r = ivy_r,
          ivy_split_r = ivy_split_r,
          ivy_r_no_preview = ivy_r_no_preview,
        },
        layout = function()
          return vim.o.columns >= 120 and { preset = "telescope" } or { preset = "dropdown_r" }
        end,
        actions = {
          diffview_open = function(_, item)
            local target
            if item.stash or item.branch then
              target = "HEAD..." .. (item.stash or item.branch)
            elseif item.commit then
              target = item.commit .. "^!"
            end
            diffview.open({ target })
          end,
          diffview_open_full = function(_, item)
            local target = item.stash or item.branch or item.commit
            diffview.open({ target })
          end,
          slime_select = function(picker, item)
            if item.pane_id then
              picker:close() -- Close the picker first so buffer options apply to the buffer we opened the picker from
              vim.g.slime_default_config = { socket_name = "default", target_pane = item.pane_id }
              vim.b.slime_config = { socket_name = "default", target_pane = item.pane_id }
            end
          end,
        },
        sources = {
          commands = { layout = { preset = "ivy_r_no_preview" } },
          command_history = { layout = { preset = "ivy_r_no_preview" } },
          diagnostics = { layout = { preset = "ivy_r" } },
          diagnostics_buffer = { layout = { preset = "ivy_r" } },
          files = { hidden = true },
          git_log = { win = git_win },
          git_log_file = { win = git_win },
          git_log_line = { win = git_win },
          git_branches = { all = true, win = git_win },
          git_stash = { win = git_win },
          registers = { layout = { preset = "ivy_r" } },
          search_history = { layout = { preset = "ivy_r_no_preview" } },
          tmux_panes = { win = tmux_win },
          tmux = { win = tmux_win },
        },
        win = {
          input = {
            keys = {
              ["<c-p>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-f>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<c-b>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-p>"] = "preview_scroll_up",
              ["<c-n>"] = "preview_scroll_down",
              ["<c-f>"] = "preview_scroll_right",
              ["<c-b>"] = "preview_scroll_left",
            },
          },
        },
      },
    })
    vim.keymap.set("n", "<leader>ff", snacks.picker.files, { desc = "[f]ind [f]iles" })
    vim.keymap.set("n", "<leader>fF", function()
      snacks.picker.files({ ignored = true, follow = true })
    end, { desc = "[f]ind all [F]iles" })
    vim.keymap.set("n", "<leader>fif", snacks.picker.grep, { desc = "[f]ind [i]n [f]iles" })
    vim.keymap.set("n", "<leader>fiF", function()
      snacks.picker.grep({ ignored = true, follow = true })
    end, { desc = "[f]ind [i]n all [F]iles" })
    vim.keymap.set("n", "<leader>fb", snacks.picker.buffers, { desc = "[f]ind [b]uffers" })
    vim.keymap.set("n", "<leader>fib", snacks.picker.grep_buffers, { desc = "[f]ind [i]n [b]uffers" })
    vim.keymap.set("n", '<leader>f"', snacks.picker.registers, { desc = '[f]ind registers ["]' })
    vim.keymap.set("n", "<leader>f/", snacks.picker.search_history, { desc = "[f]ind search history [/]" })
    vim.keymap.set("n", "<leader>f:", snacks.picker.command_history, { desc = "[f]ind command history [:]" })
    vim.keymap.set("n", "<leader>fc", snacks.picker.commands, { desc = "[f]ind [c]ommands" })
    vim.keymap.set("n", "<leader>fe", snacks.picker.diagnostics_buffer, { desc = "[f]ind [e]rrors" })
    vim.keymap.set("n", "<leader>fE", snacks.picker.diagnostics, { desc = "[f]ind all [E]rrors" })
    vim.keymap.set("n", "<leader>fh", snacks.picker.help, { desc = "[f]ind [h]elp" })
    vim.keymap.set("n", "<leader>fj", snacks.picker.jumps, { desc = "[f]ind [j]umps" })
    vim.keymap.set("n", "<leader>fp", snacks.picker.projects, { desc = "[f]ind [p]rojects" })
    vim.keymap.set("n", "<leader>fu", snacks.picker.undo, { desc = "[f]ind [u]ndo tree" })

    vim.keymap.set("n", "<leader>fgb", snacks.picker.git_branches, { desc = "[f]ind [g]it [b]ranches" })
    vim.keymap.set("n", "<leader>fgc", snacks.picker.git_log, { desc = "[f]ind [g]it [c]ommits" })
    vim.keymap.set("n", "<leader>fgf", snacks.picker.git_log_file, { desc = "[f]ind [g]it [f]ile commits" })
    vim.keymap.set("n", "<leader>fgl", snacks.picker.git_log_line, { desc = "[f]ind [g]it [l]ine commits" })
    vim.keymap.set("n", "<leader>fgS", snacks.picker.git_stash, { desc = "[f]ind [g]it [S]tash" })
    vim.keymap.set("n", "<leader>fgs", snacks.picker.git_status, { desc = "[f]ind [g]it [s]tatus" })

    vim.keymap.set("n", "<leader>ftc", snacks.picker.tmux_clients, { desc = "[f]ind [t]mux [c]lients" })
    vim.keymap.set("n", "<leader>ftp", snacks.picker.tmux_panes, { desc = "[f]ind [t]mux [p]anes" })
    vim.keymap.set("n", "<leader>ftw", snacks.picker.tmux_windows, { desc = "[f]ind [t]mux [w]indows" })
    vim.keymap.set("n", "<leader>fts", snacks.picker.tmux_sessions, { desc = "[f]ind [t]mux [s]essions" })
    vim.keymap.set("n", "<leader>ftt", snacks.picker.tmux, { desc = "[f]ind [t]mux [t]" })
  end,
}
