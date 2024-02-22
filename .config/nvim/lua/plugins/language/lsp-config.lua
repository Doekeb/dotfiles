return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        -- "ruff_lsp",
        "jedi_language_server",
        -- "pyright",
        -- "pylsp",
        -- "pylyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
    config = function()
      require("neodev").setup({})
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      -- lspconfig.ruff_lsp.setup({})
      lspconfig.jedi_language_server.setup({ capabilities = capabilities })
      -- lspconfig.pyright.setup({ capabilities = capabilities })
      -- lspconfig.pylsp.setup({ capabilities = capabilities })
      -- lspconfig.pylyzer.setup({ capabilities = capabilities })

      vim.keymap.set("n", "K", vim.lsp.buf.hover)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
    end,
  },
}
