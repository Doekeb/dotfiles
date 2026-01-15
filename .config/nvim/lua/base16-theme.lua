local colors = {
  base00 = "#1F1F28",
  base01 = "#16161D",
  base02 = "#223249",
  base03 = "#54546D",
  base04 = "#727169",
  base05 = "#DCD7BA",
  base06 = "#C8C093",
  base07 = "#717C7C",
  base08 = "#C34043",
  base09 = "#FFA066",
  base0A = "#C0A36E",
  base0B = "#76946A",
  base0C = "#6A9589",
  base0D = "#7E9CD8",
  base0E = "#957FB8",
  base0F = "#D27E99",
}
return {
  colors = colors,
  lualine_theme = {
    command = {
      a = {
        bg = colors.base0A,
        fg = colors.base01,
      },
      b = {
        bg = colors.base02,
        fg = colors.base05,
      },
      c = {
        bg = colors.base01,
        fg = colors.base0A,
      },
    },
    inactive = {
      a = {
        bg = colors.base01,
        fg = colors.base0D,
      },
      b = {
        bg = colors.base01,
        fg = colors.base0D,
      },
      c = {
        bg = colors.base01,
        fg = colors.base0D,
      },
    },
    insert = {
      a = {
        bg = colors.base0E,
        fg = colors.base01,
      },
      b = {
        bg = colors.base02,
        fg = colors.base05,
      },
      c = {
        bg = colors.base01,
        fg = colors.base0E,
      },
    },
    normal = {
      a = {
        bg = colors.base0D,
        fg = colors.base01,
      },
      b = {
        bg = colors.base02,
        fg = colors.base05,
      },
      c = {
        bg = colors.base01,
        fg = colors.base0D,
      },
    },
    replace = {
      a = {
        bg = colors.base0C,
        fg = colors.base01,
      },
      b = {
        bg = colors.base02,
        fg = colors.base05,
      },
      c = {
        bg = colors.base01,
        fg = colors.base0C,
      },
    },
    visual = {
      a = {
        bg = colors.base09,
        fg = colors.base01,
      },
      b = {
        bg = colors.base02,
        fg = colors.base05,
      },
      c = {
        bg = colors.base01,
        fg = colors.base09,
      },
    },
  },
}
