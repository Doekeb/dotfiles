local file = io.open("/etc/lsb-release", "r")
local is_nix
if file then
  for line in file:lines() do
    if line:match("DISTRIB_ID=(.*)") == "nixos" then
      is_nix = true
    end
  end
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = not is_nix and ":TSUpdate" or nil,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "*" },
      callback = function()
        pcall(vim.treesitter.start)
        -- If you need more features:
        -- if pcall(vim.treesitter.start) then
        --   -- treesitter-based fold
        --   vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        --   vim.wo[0][0].foldmethod = "expr"
        --   -- treesitter-based indents
        --   vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        -- end
      end,
    })
  end,
}
