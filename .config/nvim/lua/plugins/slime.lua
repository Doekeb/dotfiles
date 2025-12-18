return {
  "jpalardy/vim-slime",
  name = "slime",
  dependencies = { "linux-cultist/venv-selector.nvim" },
  config = function()
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
      if os.rename(".env", ".env") then
        local source_dotenv = { "source", ".env" }
        local cmd = { "tmux", "send-keys", "-t", pane_id, "'" .. table.concat(source_dotenv, " ") .. "'", "ENTER" }
        vim.fn.system(table.concat(cmd, " "))
      end
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

    -- New slime pane mappings
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

    -- Slime config mappings
    vim.keymap.set("n", "<leader>sc", function()
      tmux_pane_picker(themes.get_dropdown())
    end, { remap = true })

    -- Slime send mappings
    vim.keymap.set("x", "<leader>s", "<Plug>SlimeRegionSendgv<esc>)", { remap = true })
    vim.keymap.set("n", "<leader>s", "<Plug>SlimeMotionSend", {})
    vim.keymap.set("n", "<leader>ss", "^<Plug>SlimeMotionSendasvas<esc>)", { remap = true })
    -- vim.keymap.set("n", "<leader>ss", function()
    --   local keys = vim.api.nvim_replace_termcodes("^<Plug>SlimeMotionSendasvas<esc>", true, true, true)
    --   if not pcall(vim.cmd.normal, keys) then
    --     tmux_pane_picker(themes.get_dropdown())
    --   end
    -- end, { remap = true })
  end,
}
