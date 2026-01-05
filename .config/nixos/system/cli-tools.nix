{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    eza
    fd
    fzf
    htop
    jq
    ripgrep
    uv
    yq
  ];
}
