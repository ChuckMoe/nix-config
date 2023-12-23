{ pkgs, ... }:

{
  home.packages = with pkgs; [ thunderbird ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
  };
}
