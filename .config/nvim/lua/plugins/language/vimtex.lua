return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    vim.g.vimtex_view_method = "zathura"
    -- vim.opt.wrap = true
    vim.cmd([[syntax enable]])
  end,
}
