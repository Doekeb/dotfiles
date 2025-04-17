return {
  "saghen/blink.cmp",
  version = "v0.*",
  opts = {
    keymap = {
      preset = "default",
      -- ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ["<C-space>"] = {},
      ["<S-tab>"] = { "select_and_accept" },

      -- ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      -- ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-b>"] = {},
      ["<C-f>"] = {},
    },

    appearance = { nerd_font_variant = "normal" },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    signature = { enabled = true, window = { border = "rounded", winblend = 10 } },
    completion = {
      keyword = { range = "full" },
      menu = {
        border = "rounded",
        winblend = 10,
        -- winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
      },
      list = { selection = { preselect = true, auto_insert = false } },
      ghost_text = { enabled = true },
      documentation = {
        auto_show = true,
        -- auto_show_delay_ms = 500,
        auto_show_delay_ms = 0,
        update_delay_ms = 50,
        -- update_delay_ms = 0,
        window = {
          max_width = 88,
          border = "rounded",
          winblend = 10,
        },
      },
    },
  },
}
