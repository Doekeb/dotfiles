# /etc/nixos/flake.nix
{
  description = "flake for doeke-lemur-pro";

  inputs = {
    # UNSTABLE
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # stylix = {
    #   url = "github:nix-community/stlyix/release-25.11";
    #   inputs.nixpks.follows = "nixpkgs";
    # };

    # # STABLE
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    stylix.url = "github:nix-community/stylix/release-25.11";
  };

  outputs =
    { nixpkgs, stylix, ... }:
    {
      nixosConfigurations = {
        doeke-lemur-pro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            stylix.nixosModules.stylix
            ./system
          ];
        };
      };
    };
}
