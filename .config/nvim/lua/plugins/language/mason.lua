return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({})
    local tools = {}
    vim.list_extend(tools, { "bashls", "biome", "lua_ls", "pylsp", "ruff_lsp", "taplo" }) -- lsp tools
    vim.list_extend(tools, { "flake8", "mypy", "pylint" }) -- null_ls tools
    vim.list_extend(tools, { "biome", "black", "isort", "stylua" }) -- conform tools
    require("mason-tool-installer").setup({ ensure_installed = tools })
  end,
}
