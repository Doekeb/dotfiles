{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Python
    basedpyright
    black
    # flake8 - No python-version-agnostic Nix package
    isort
    mypy
    pylint
    pyright
    ruff
    ty

    # SQL
    sqlfluff

    # Shell
    bash-language-server

    # JS/TS
    biome
    deno
    vtsls

    # Vim-related (Lua, Vim)
    lua-language-server
    stylua
    vim-language-server

    # System-related (Nix, Hypr)
    nixd
    nil
    hyprls

    # Configuration languages (YAML, TOML, ...)
    taplo
    yaml-language-server

    # Other (not really LSP-ish)
    # "cronstrue"
    # yq
  ];
}
