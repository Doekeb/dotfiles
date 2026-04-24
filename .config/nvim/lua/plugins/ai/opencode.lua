return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  config = function()
    local opencode = require("opencode")
    local start_opencode = function(where)
      local new_pane_cmd = "tmux split-window -" .. where .. "dPF '#{pane_id}'"
      local result = vim.fn.systemlist(new_pane_cmd)

      local new_pane_id
      if result and #result > 0 then
        new_pane_id = result[1]
      end

      local cmd = { "tmux", "send-keys", "-t", new_pane_id, "'" .. "opencode --port" .. "'", "ENTER" }
      vim.fn.system(table.concat(cmd, " "))
    end
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
      server = {
        start = function()
          return start_opencode("h")
        end,
      },
      -- lsp = { enabled = true },
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    vim.keymap.set("n", "<leader>onn", function()
      start_opencode("h")
    end, { desc = "Start opencode" })
    vim.keymap.set("n", "<leader>on|", function()
      start_opencode("h")
    end, { desc = "Start opencode to the right" })
    vim.keymap.set("n", "<leader>on_", function()
      start_opencode("v")
    end, { desc = "Start opencode below" })

    vim.keymap.set({ "n", "x" }, "<leader>O", function()
      opencode.ask("@this: ", { submit = true })
    end, { desc = "Ask [O]pencode" })

    vim.keymap.set({ "n", "x" }, "<leader>o", function()
      return opencode.operator("@this ")
    end, { desc = "Add to [o]pencode", expr = true })

    vim.keymap.set("n", "<leader>ob", function()
      return opencode.prompt("@buffer ")
    end, { desc = "Add [o]pencode [b]uffer" })
  end,
}
