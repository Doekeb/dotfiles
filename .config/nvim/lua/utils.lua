return {
  set_global_keymap = function(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end,
  set_local_keymap = function(mode, lhs, rhs, desc)
    local opts = { noremap = true, silent = true, buffer = 0, desc = desc }
    vim.keymap.set(mode, lhs, rhs, opts)
  end,
}
