# /etc/nixos/flake.nix
{
  description = "flake for lemur-pro";

  inputs = {
    # UNSTABLE
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # stylix = {
    #   url = "github:nix-community/stylix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # STABLE
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # home-manager.url = "github:nix-community/home-manager/release-25.11";
    # stylix.url = "github:nix-community/stylix/release-25.11";
  };

  outputs =
    {
      nixpkgs,
      # stylix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        lemur-pro = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system
            # home-manager.nixosModules.default
            # stylix.nixosModules.stylix
          ];
        };
      };
    };
}
