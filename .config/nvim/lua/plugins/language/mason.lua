return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({})
    local tools = {}
    vim.list_extend(tools, { "lua_ls", "pylsp", "biome" }) -- lsp tools
    vim.list_extend(tools, { "mypy", "flake8", "pylint" }) -- null_ls tools
    vim.list_extend(tools, { "stylua", "isort", "black" }) -- conform tools
    require("mason-tool-installer").setup({ ensure_installed = tools })
  end,
}
