{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    configure.customLuaRC =
      let
        grammarsPath = pkgs.symlinkJoin {
          name = "nvim-treesitter-grammars";
          paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
      in
      ''
        -- make sure the real init file gets sourced
        -- vim.print(os.getenv("HOME") .. "/.config/nvim/init.lua")
        dofile(os.getenv("HOME") .. "/.config/nvim/init.lua")

        -- also make sure to append treesitter since it bundles some languages
        -- vim.print("${pkgs.vimPlugins.nvim-treesitter}")
        vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter}")

        -- append all *.so files
        -- vim.print("${grammarsPath}")
        vim.opt.runtimepath:append("${grammarsPath}")
      '';
  };
}
