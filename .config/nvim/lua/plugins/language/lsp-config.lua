return {
  "neovim/nvim-lspconfig",
  dependencies = { "folke/neodev.nvim" },
  config = function()
    require("neodev").setup({})
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      opts.desc = "show hover help"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "show [e]rrors"
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

      opts.desc = "[g]o to [D]eclaration"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "[g]o to [d]efinition"
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

      opts.desc = "[g]o [f]ormat"
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)
    end

    -- Monkeypatch to make all floating windows have borders
    local _open_floating_preview = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return _open_floating_preview(contents, syntax, opts, ...)
    end

    -- Show diagnostic source
    vim.diagnostic.config({ float = { source = true } })

    lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })

    -- This is so we can use it in virtual environment setup
    lspconfig.pylsp_config = {
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            autopep8 = { enabled = false },
            flake8 = { enabled = false },
            mccabe = { enabled = false },
            preload = { enabled = false },
            pycodestyle = { enabled = false },
            pydocstyle = { enabled = false },
            pyflakes = { enabled = false },
            pylint = { enabled = false },
            rope = { enabled = false },
            yapf = { enabled = false },
          },
        },
      },
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.opt_local.colorcolumn = "89"
      end,
    }
    lspconfig.pylsp.setup(lspconfig.pylsp_config)
  end,
}
