return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({})
    local tools = {}
    vim.list_extend(
      tools,
      { "basedpyright", "bashls", "biome", "lua_ls", "pylsp", "pyright", "ruff", "taplo", "vimls" }
    ) -- lsp tools
    vim.list_extend(tools, { "flake8", "mypy", "pylint", "sqlfluff" }) -- nvim-lint tools
    vim.list_extend(tools, { "biome", "black", "isort", "sqlfluff", "stylua" }) -- conform tools
    require("mason-tool-installer").setup({ ensure_installed = tools })
  end,
}
