{ pkgs, lib, config, outputs, hostname, ... }:
let
  user = "misterio";
  cage = "${pkgs.cage}/bin/cage";
  greetd = "${pkgs.greetd.greetd}/bin/greetd";
  gtkgreet = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";

  homeConfig = outputs.homeConfigurations."misterio@${hostname}".config;

  hasSteam = config.programs.steam.enable;
  hasSway = homeConfig.wayland.windowManager.sway.enable;
  hasHyprland = homeConfig.wayland.windowManager.hyprland.enable;

  kioskCmd = "${pkgs.sway}/bin/sway --config ${pkgs.writeText "kiosk.config" ''
    exec "${gtkgreet} -l &>/dev/null; ${pkgs.sway}/bin/swaymsg exit"
  ''}";

  steam-bigpicture = pkgs.writeShellScriptBin "steam-bigpicture" ''
    ${pkgs.cage}/bin/cage -- ${pkgs.steam}/bin/steam -bigpicture
  '';
in
{
  environment.systemPackages = lib.mkIf hasSteam [ steam-bigpicture ];

  environment.etc."greetd/environments".text =
    lib.optionalString hasHyprland "Hyprland\n" +
    lib.optionalString hasSway "sway\n" +
    "$SHELL\n" +
    lib.optionalString hasSteam "steam-bigpicture\n";

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        inherit user;
        command = kioskCmd;
      };
      initial_session = {
        inherit user;
        command =
          if hasSway then "sway"
          else if hasHyprland then "Hyprland"
          else "$SHELL -l";
      };
    };
  };
}
