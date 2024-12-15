return {
  "jpalardy/vim-slime",
  name = "slime",
  dependencies = { "linux-cultist/venv-selector.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local tmux_pane_picker = function(opts)
      opts = opts or {}
      local session_id, window_id =
        vim.fn.systemlist({ "tmux", "display-message", "-p", "#{session_id} #{window_id}" })[1]:match("^(%S+)%s+(.+)")
      local arrows = {
        "#{?#{&&:#{&&:#{pane_at_top},#{!=:#{pane_at_bottom},1}},#{==:#{pane_at_left},#{pane_at_right}}},󰁞,}", -- Check top
        "#{?#{&&:#{&&:#{pane_at_bottom},#{!=:#{pane_at_top},1}},#{==:#{pane_at_left},#{pane_at_right}}},󰁆,}", -- Check bottom
        "#{?#{&&:#{&&:#{pane_at_left},#{!=:#{pane_at_right},1}},#{==:#{pane_at_top},#{pane_at_bottom}}},󰁎,}", -- Check left
        "#{?#{&&:#{&&:#{pane_at_right},#{!=:#{pane_at_left},1}},#{==:#{pane_at_top},#{pane_at_bottom}}},󰁕,}", -- Check right

        "#{?#{&&:#{&&:#{pane_at_left},#{!=:#{pane_at_right},1}},#{&&:#{pane_at_top},#{!=:#{pane_at_bottom},1}}},󰧄,}", -- Check top-left
        "#{?#{&&:#{&&:#{pane_at_right},#{!=:#{pane_at_left},1}},#{&&:#{pane_at_top},#{!=:#{pane_at_bottom},1}}},󰧆,}", -- Check top-right
        "#{?#{&&:#{&&:#{pane_at_left},#{!=:#{pane_at_right},1}},#{&&:#{pane_at_bottom},#{!=:#{pane_at_top},1}}},󰦸,}", -- Check bottom-left
        "#{?#{&&:#{&&:#{pane_at_right},#{!=:#{pane_at_left},1}},#{&&:#{pane_at_bottom},#{!=:#{pane_at_top},1}}},󰦺,}", -- Check bottom-right

        "#{?#{&&:#{==:#{pane_at_left},#{pane_at_right}},#{==:#{pane_at_top},#{pane_at_bottom}}},󰧞,}", -- Check middle
      }
      local format = {
        table.concat(arrows),
        "#{pane_current_command}",
        "Session: #{session_name}",
        "Window: #{window_index} #{window_name}",
        "Pane: #{pane_index}",
      }
      local data = {
        "#{pane_id}",
        -- string.format("#{!=:#{session_id},%s}#{!=:#{window_id},%s}", session_id, window_id),
      }
      local cmd = { "tmux", "list-panes", "-aF", table.concat(data, " ") .. " " .. table.concat(format, " | ") }
      local results = vim.fn.systemlist(cmd)

      pickers
        .new(opts, {
          prompt_title = "tmux pane",
          finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
              local value, display = entry:match("^(%S+)%s+(.+)")
              return {
                value = value,
                display = display,
                ordinal = entry,
              }
            end,
          }),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              vim.g.slime_default_config = { socket_name = "default", target_pane = selection.value }
              vim.b.slime_config = { socket_name = "default", target_pane = selection.value }
            end)
            return true
          end,
        })
        :find()
    end

    local venv_selector = require("venv-selector")

    local slime_new = function(where)
      local cmd = "tmux split-window -" .. where .. "dPF '#{pane_id}'"
      local result = vim.fn.systemlist(cmd)

      -- Extract the pane ID from the output
      local new_pane_id
      if result and #result > 0 then
        new_pane_id = result[1]
      end

      vim.g.slime_default_config = { socket_name = "default", target_pane = new_pane_id }
      vim.b.slime_config = { socket_name = "default", target_pane = new_pane_id }
      return new_pane_id
    end

    local slime_start_python = function(pane_id)
      local active_venv = venv_selector.venv()
      local p
      if active_venv then
        local activate = { "source", venv_selector.venv_tool_path(active_venv, "activate") }
        local cmd = { "tmux", "send-keys", "-t", pane_id, "'" .. table.concat(activate, " ") .. "'", "ENTER" }
        vim.fn.system(table.concat(cmd, " "))
        p = venv_selector.venv_tool_path(active_venv, "ipython") and "'ipython'" or "'python'"
      else
        p = (vim.fn.executable("ipython") == 1) and "'ipython'" or "'python'"
      end
      local cmd = { "tmux", "send-keys", "-t", pane_id, p, "ENTER" }
      vim.fn.system(table.concat(cmd, " "))
    end

    vim.api.nvim_create_user_command("SlimeNew", function()
      slime_new("h")
    end, {})
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_target = "tmux"
    vim.g.slime_bracketed_paste = 1
    vim.g.slime_no_mappings = 1
    vim.keymap.set("n", "<leader>snn", function()
      slime_new("h")
    end, {})
    vim.keymap.set("n", "<leader>sn|", function()
      slime_new("h")
    end, {})
    vim.keymap.set("n", "<leader>sn_", function()
      slime_new("v")
    end, {})
    vim.keymap.set("n", "<leader>spp", function()
      local pane_id = slime_new("h")
      slime_start_python(pane_id)
    end, {})
    vim.keymap.set("n", "<leader>sp|", function()
      local pane_id = slime_new("h")
      slime_start_python(pane_id)
    end, {})
    vim.keymap.set("n", "<leader>sp_", function()
      local pane_id = slime_new("v")
      slime_start_python(pane_id)
    end, {})
    -- tmux_pane(require("telescope.themes").get_dropdown({}))
    vim.keymap.set("n", "<leader>sc", function()
      tmux_pane_picker(require("telescope.themes").get_dropdown({}))
    end, { remap = true })
    vim.keymap.set("x", "<leader>s", "<Plug>SlimeRegionSendgv<esc>)", { remap = true })
    vim.keymap.set("n", "<leader>s", "<Plug>SlimeMotionSend", {})
    vim.keymap.set("n", "<leader>ss", "^<Plug>SlimeMotionSendasvas<esc>)", { remap = true })
  end,
}
