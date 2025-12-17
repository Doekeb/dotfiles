return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "purarue/gitsigns-yadm.nvim", opts = { shell_timeout_ms = 1000 } },
  },
  config = function()
    require("gitsigns").setup({
      _on_attach_pre = function(bufnr, callback)
        require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
      end,
      numhl = true,
      current_line_blame_opts = { delay = 0 },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions I want
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end)
        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)

        -- Actions I don't like
        -- map("n", "<leader>hp", gitsigns.preview_hunk)
        -- map("n", "<leader>hi", gitsigns.preview_hunk_inline)
        -- map("n", "<leader>hb", function()
        --   gitsigns.blame_line({ full = true })
        -- end)
        -- map("n", "<leader>hd", gitsigns.diffthis)
        -- map("n", "<leader>hD", function()
        --   gitsigns.diffthis("~")
        -- end)
        -- map("n", "<leader>hQ", function()
        --   gitsigns.setqflist("all")
        -- end)
        -- map("n", "<leader>hq", gitsigns.setqflist)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
        map({ "o", "x" }, "ah", gitsigns.select_hunk)

        -- Big toggle
        map("n", "<leader>tg", function()
          gitsigns.toggle_current_line_blame()
          gitsigns.toggle_deleted()
          gitsigns.toggle_word_diff()
          gitsigns.toggle_linehl()
        end)
      end,
    })
  end,
}
