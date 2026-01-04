{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;

	#    configure.customLuaRC =
	#      let
	#        grammarsPath = pkgs.symlinkJoin {
	#          name = "nvim-treesitter-grammars";
	#          paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
	#        };
	#      in
	#      ''
	#        -- also make sure to append treesitter since it bundles some languages
	# vim.print("${pkgs.vimPlugins.nvim-treesitter}")
	#        vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter}")
	#        -- append all *.so files
	# vim.print("${grammarsPath}")
	#        vim.opt.runtimepath:append("${grammarsPath}")
	#      '';

    # configure.packages.myPlugins = with pkgs.vimPlugins; {
    #   start = [
    #     (nvim-treesitter.withPlugins (plugins: with plugins; [ nix ]))
    #   ];
    # };

    # extraLuaConfig =
    #   # lua
    #   ''
    #     require("lazy").setup()
    #   '';

    # configure.packages.myVimPackage = with pkgs.vimPlugins; {
    #   start = [
    #     (nvim-treesitter.withPlugins (plugins: with plugins; [ nix ]))
    #   ];
    # };

    # plugins = [
    #   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    # ];
    # extraPackages = with pkgs; [ gcc ];
  };
}
