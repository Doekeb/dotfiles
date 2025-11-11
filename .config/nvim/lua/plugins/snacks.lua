return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      layouts = {
        dropdown_r = {
          reverse = true,
          layout = {
            backdrop = false,
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.8,
            border = "none",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.4, border = true },
            {
              box = "vertical",
              border = true,
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "list" },
              { win = "input", height = 1, border = "top" },
            },
          },
        },
        select_r = {
          hidden = { "preview" },
          reverse = true,
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            max_width = 100,
            height = 0.4,
            min_height = 2,
            box = "vertical",
            border = true,
            title = "{title}",
            title_pos = "center",
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
            { win = "list", border = "none" },
            { win = "input", height = 1, border = "top" },
          },
        },
        telescope_r = {
          reverse = false,
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = true },
              {
                win = "input",
                height = 1,
                border = true,
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.45,
              border = true,
              title_pos = "center",
            },
          },
        },
      },
      layout = function()
        return vim.o.columns >= 120 and { preset = "telescope" } or { preset = "dropdown_r" }
      end,
    },
  },
}
