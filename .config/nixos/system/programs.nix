# Programs that don't need any extra configuration
{ pkgs, ... }:
{
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    mongodb-compass
    slack
    # notion-app
  ];
}
