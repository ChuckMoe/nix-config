{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protonvpn-cli_2
    protonvpn-gui
  ];
}
