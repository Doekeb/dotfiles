# Programs that don't need any extra configuration
{ pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.zoom-us.enable = true;
  environment.systemPackages = with pkgs; [
    mongodb-compass
    slack
    # notion-app
  ];
}
