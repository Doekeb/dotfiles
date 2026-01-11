{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # nerd-fonts.monofur
    # nerd-fonts.noto
    # noto-fonts
    # noto-fonts-cjk-sans
    # noto-fonts-color-emoji
    # liberation_ttf
    # fira-code
    # fira-code-symbols
    # mplus-outline-fonts.githubRelease
    # dina-font
    # proggyfonts
  ];
  # fonts.fontconfig = {
  #   enable = true;
  #   defaultFonts = {
  #     serif = [ "Monofur" ];
  #     sansSerif = [ "Monofur" ];
  #     monospace = [ "Monofur" ];
  #   };
  # };
}
