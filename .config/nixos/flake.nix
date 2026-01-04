# /etc/nixos/flake.nix
{
  description = "flake for doeke-lemur-pro";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        doeke-lemur-pro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./system
          ];
        };
      };
    };
}
