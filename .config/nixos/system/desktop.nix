{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rofi
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
        user = "greeter";
      };
      # default_session = initial_session;
    };
  };
  # environment.etc."greetd/environments".text = ''
  #   hyprland
  #   fish
  #   bash
  # '';
}
