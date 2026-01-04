{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yq
    jq
    uv
    ripgrep
    fzf
    fd
    eza
    bat
  ];
}
