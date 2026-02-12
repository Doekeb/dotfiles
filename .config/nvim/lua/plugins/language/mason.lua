local file = io.open("/etc/lsb-release", "r")
local is_nix
if file then
  for line in file:lines() do
    if line:match("DISTRIB_ID=(.*)") == "nixos" then
      is_nix = true
    end
  end
end

if is_nix then
  return {}
else
  return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({ automatic_enable = false })
      local tools = {}
      vim.list_extend(tools, {
        "basedpyright",
        "bashls",
        "biome",
        "deno",
        "dockerfile-language-server",
        "lua_ls",
        "pylsp",
        "pyright",
        "ruff",
        "taplo",
        "ty",
        "vimls",
        "vtsls",
      }) -- lsp tools
      vim.list_extend(tools, { "flake8", "mypy", "pylint", "sqlfluff" }) -- nvim-lint tools
      vim.list_extend(tools, { "biome", "black", "isort", "sqlfluff", "stylua" }) -- conform tools
      vim.list_extend(tools, { "yq", "yaml-language-server", "cronstrue" }) -- bespoke tools
      require("mason-tool-installer").setup({ ensure_installed = tools })
    end,
  }
end
