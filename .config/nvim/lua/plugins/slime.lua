return {
  "jpalardy/vim-slime",
  name = "slime",
  config = function()
    local slime_new = function()
      local cmd = "tmux split-window -hdPF '#{pane_id}'"
      local new_pane_id = vim.fn.systemlist(cmd)

      -- Extract the pane ID from the output
      if new_pane_id and #new_pane_id > 0 then
        new_pane_id = new_pane_id[1]
        print("New pane ID: " .. new_pane_id)
      else
        print("Failed to get new pane ID")
      end

      local bootstrap_cmd = "tmux send-keys -t " .. new_pane_id .. " 'poetry shell' ENTER 'ipython' ENTER"
      vim.fn.system(bootstrap_cmd)

      -- print("hello!")
      -- Execute Tmux command to split the current window horizontally
      -- vim.fn.system("tmux split-window -vP")

      -- Execute Tmux command to get the ID of the newly created pane
      -- local pane_id = vim.fn.system("tmux display-message -p '#{pane_id}'")
      -- local pane_id = vim.fn.system("tmux split-window -vdPF '#{pane_id}'")
      -- Remove trailing newline character from the output
      -- pane_id = pane_id:gsub("%s+", "")
      -- print(pane_id)
      -- Now you have the pane_id, you can react to it as needed
      -- print("New pane created with ID: " .. pane_id)
      -- vim.api.nvim_command(
      --   'let g:slime_default_config = {"socket_name": "default", "target_pane": "' .. blah .. '"}'
      -- )
      vim.g.slime_default_config = { socket_name = "default", target_pane = new_pane_id }
    end
    -- local slime = require("slime")
    vim.api.nvim_create_user_command("SlimeNew", slime_new, {})
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_target = "tmux"
    vim.g.slime_bracketed_paste = 1
    vim.g.slime_no_mappings = 1
    vim.keymap.set("n", "<leader>sn", slime_new, {})
    vim.keymap.set("x", "<leader>s", "<Plug>SlimeRegionSend", {})
    vim.keymap.set("n", "<leader>s", "<Plug>SlimeMotionSend", {})
    vim.keymap.set("n", "<leader>ss", "^<Plug>SlimeMotionSendasvas<esc>)", { remap = true })
  end,
}
