return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  init = function()
    vim.g.no_plugin_maps = true
  end,
  config = function()
    local textobjects = require("nvim-treesitter-textobjects")
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")
    local repeatable_move = require("nvim-treesitter-textobjects.repeatable_move")
    textobjects.setup({
      select = {
        enable = true,
        lookahead = true,
        selection_modes = {
          ["@function.outer"] = "V",
          ["@function.inner"] = "V",
          ["@class.outer"] = "V",
          ["@class.inner"] = "V",
          ["@loop.outer"] = "V",
          ["@loop.inner"] = "V",
          ["@conditional.outer"] = "V",
          ["@conditional.inner"] = "V",
          ["@statement.outer"] = "V",
        },
      },
      move = { set_jumps = true },
    })
    local keymaps = {
      select_textobject = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["as"] = "@statement.outer",
        ["is"] = "@statement.outer",
        ["a/"] = "@comment.outer",
        ["i/"] = "@comment.inner",
      },
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = { "@class.outer", "@function.outer" },
        ["]}"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = { "@class.outer", "@function.outer" },
        ["]{"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = { "@class.outer", "@function.outer" },
        ["[{"] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = { "@class.outer", "@function.outer" },
        ["[}"] = "@class.outer",
      },
      goto_next = {
        [")"] = "@statement.outer",
      },
      goto_previous = {
        ["("] = "@statement.outer",
      },
    }
    for keys, cls in pairs(keymaps.select_textobject) do
      vim.keymap.set({ "x", "o" }, keys, function()
        select.select_textobject(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_next_start) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next_start(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_next_end) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next_end(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_previous_start) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous_start(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_previous_end) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous_end(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_next) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_next(cls, "textobjects")
      end)
    end
    for keys, cls in pairs(keymaps.goto_previous) do
      vim.keymap.set({ "n", "x", "o" }, keys, function()
        move.goto_previous(cls, "textobjects")
      end)
    end
    vim.keymap.set({ "n", "x", "o" }, ";", repeatable_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", repeatable_move.repeat_last_move_previous)
    vim.keymap.set({ "n", "x", "o" }, "f", repeatable_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", repeatable_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", repeatable_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", repeatable_move.builtin_T_expr, { expr = true })
  end,
}
