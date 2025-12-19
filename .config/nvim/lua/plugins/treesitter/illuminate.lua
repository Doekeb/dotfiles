return {
  "RRethy/vim-illuminate",
  config = function()
    require("illuminate").configure({
      providers = { "lsp", "treesitter" },
      delay = 50,
    })
  end,
}
