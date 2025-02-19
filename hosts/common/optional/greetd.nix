{ pkgs, lib, config, ... }:
let
  homeCfgs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (n: v: "${v.home.path}/share") homeCfgs;
  vars = ''XDG_DATA_DIRS="$XDG_DATA_DIRS:${lib.concatStringsSep ":" homeSharePaths}"'';

  moeCfg = homeCfgs.moe;
  gtkTheme = moeCfg.gtk.theme;
  iconTheme = moeCfg.gtk.iconTheme;
  wallpaper = moeCfg.wallpaper;

  sway-kiosk = command: "${lib.getExe pkgs.sway} --config ${pkgs.writeText "kiosk.config" ''
    output * bg #000000 solid_color
    xwayland disable
    input "type:touchpad" {
      tap enabled
    }
    exec 'GTK_USE_PORTAL=0 ${vars} ${command}; ${pkgs.sway}/bin/swaymsg exit'
  ''}";
in
{
  users.extraUsers.greeter = {
    packages = [
      gtkTheme.package
      iconTheme.package
    ];
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        icon_theme_name = "Papirus";
        theme_name = gtkTheme.name;
      };
      background = {
        path = wallpaper;
        fit = "Cover";
      };
    };
  };
  services.greetd = {
    enable = true;
    settings.default_session.command = sway-kiosk (lib.getExe config.programs.regreet.package);
  };
}
