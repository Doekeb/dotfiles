local venv_tool_path = function(venv_path, tool_name)
  local path = venv_path .. "/bin/" .. tool_name
  if os.rename(path, path) then
    return path
  end
end

local null_ls_python_venv_tool_config = function(venv_path, tool_name)
  local config = {
    cwd = function()
      return vim.fn.getcwd()
    end,
  }
  local command = venv_path .. "/bin/" .. tool_name
  if os.rename(command, command) then
    config.command = command
    config.name = tool_name .. " (venv)"
  end
  return config
end

return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvimtools/none-ls.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local null_ls_hook = function(venv_path, _)
      local null_ls = require("null-ls")
      -- Disable python tools so we can re-register them using correct working directory and executable
      local python_venv_sources = {}
      for k, source in ipairs(null_ls.python_sources) do
        null_ls.disable(source.name)
        python_venv_sources[k] = source.with(null_ls_python_venv_tool_config(venv_path, source.name))
      end
      null_ls.register({
        sources = python_venv_sources,
      })
    end

    local pylsp_hook = function(venv_path, _)
      local lspconfig = require("lspconfig")
      local pylsp_config = { settings = { pylsp = { plugins = { jedi = { environment = venv_path } } } } }
      lspconfig.pylsp_config = vim.tbl_deep_extend("force", lspconfig.pylsp_config or {}, pylsp_config)

      -- local flake8_path = venv_tool_path(venv_path, "flake8")
      -- if flake8_path then
      --   lspconfig.pylsp_config.settings.pylsp.plugins.flake8 = lspconfig.pylsp_config.settings.pylsp.plugins.flake8 or {}
      --   lspconfig.pylsp_config.settings.pylsp.plugins.flake8.enabled = true
      --   lspconfig.pylsp_config.settings.pylsp.plugins.flake8.executable = flake8_path
      -- end

      lspconfig.pylsp.setup(lspconfig.pylsp_config)
    end

    require("venv-selector").setup({
      name = { "venv", ".venv", "env" }, -- Remove "env" eventually
      changed_venv_hooks = { null_ls_hook, pylsp_hook },
    })

    vim.api.nvim_create_autocmd("VimEnter", { command = "VenvSelectCached" })
  end,
  event = "VeryLazy",
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
  },
}
