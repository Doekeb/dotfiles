{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bat
    duckdb
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
