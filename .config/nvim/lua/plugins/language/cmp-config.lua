return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        floating_window_above_cur_line = false,
        hint_enable = false,
        hint_prefix = "",
        select_signature_key = "<C-n>",
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")
      local cwd = vim.fn.getcwd()
      require("luasnip.loaders.from_vscode").load({
        paths = { cwd .. "/.vscode" },
      })
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        ls.jump(-1)
      end, { silent = true })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      -- { "hrsh7th/cmp-nvim-lsp-signature-help" },
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<S-Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = false }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          -- { name = "nvim_lsp_signature_help" },
        }),
      })
    end,
  },
}
