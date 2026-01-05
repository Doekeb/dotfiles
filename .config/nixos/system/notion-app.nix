# Programs that don't need any extra configuration
{ pkgs, ... }:
{
  nixpkgs.config.allowUnsupportedSystem = true;
  environment.systemPackages = with pkgs; [
    notion-app
  ];
}
