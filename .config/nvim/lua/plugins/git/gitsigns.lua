return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "purarue/gitsigns-yadm.nvim", opts = { shell_timeout_ms = 1000 } },
  },
  config = function()
    require("gitsigns").setup({
      _on_attach_pre = function(_, callback)
        require("gitsigns-yadm").yadm_signs(callback)
      end,
      numhl = true,
      current_line_blame_opts = { delay = 0 },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>tg", function()
          gs.toggle_current_line_blame()
          gs.toggle_deleted()
          gs.toggle_word_diff()
          gs.toggle_linehl()
        end)
        -- map("n", "<leader>hS", gs.stage_buffer)
        -- map("n", "<leader>hu", gs.undo_stage_hunk)
        -- map("n", "<leader>hR", gs.reset_buffer)
        -- map("n", "<leader>hp", gs.preview_hunk)
        -- map("n", "<leader>hb", function()
        --   gs.blame_line({ full = true })
        -- end)
        -- map("n", "<leader>tb", gs.toggle_current_line_blame)
        -- map("n", "<leader>hd", gs.diffthis)
        -- map("n", "<leader>hD", function()
        --   gs.diffthis("~")
        -- end)
        -- map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    })
  end,
}
