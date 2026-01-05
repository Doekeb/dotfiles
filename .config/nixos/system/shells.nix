{ pkgs, ... }:
{
  programs.fish.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    nushell
  ];
}
