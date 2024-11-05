return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "ini",
        "json",
        "lua",
        "gitcommit",
        "gitignore",
        "markdown",
        "python",
        "rust",
        "sql",
        "toml",
        "vim",
        "vimdoc",
      },
      ignore_install = {},
      auto_install = true,
      modules = {},
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-]>",
          node_incremental = "<A-]>",
          scope_incremental = "<A-}>",
          node_decremental = "<A-[>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
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
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = { "@class.outer", "@function.outer" } },
            [")"] = "@statement.outer",
            ["]}"] = "@class.outer",
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            -- ["]o"] = "@loop.*",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            -- ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = { query = { "@class.outer", "@function.outer" } },
            ["]{"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = { query = { "@class.outer", "@function.outer" } },
            ["("] = "@statement.outer",
            ["[{"] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = { query = { "@class.outer", "@function.outer" } },
            ["[}"] = "@class.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          -- goto_next = {
          --   ["]d"] = "@conditional.outer",
          -- },
          -- goto_previous = {
          --   ["[d"] = "@conditional.outer",
          -- },
        },
      },
      refactor = {
        -- highlight_definitions = {
        --   enable = true,
        --   -- Set to false if you have an `updatetime` of ~100.
        --   clear_on_cursor_move = true,
        -- },
        -- highlight_current_scope = { enable = true },
        smart_rename = {
          enable = true,
          -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
          keymaps = {
            smart_rename = "<leader>rn",
          },
        },
      },
    })
  end,
}
