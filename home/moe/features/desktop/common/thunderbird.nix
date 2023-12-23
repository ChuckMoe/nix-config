{ pkgs, ... }:

{
  programs.thunderbird = {
    enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
  };
}
