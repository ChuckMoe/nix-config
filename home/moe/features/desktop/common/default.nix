{
  imports = [
    ./discord.nix
    ./dragon.nix
    ./firefox.nix
    ./font.nix
    ./gtk.nix
    ./kdeconnect.nix
    ./pavucontrol.nix
    ./playerctl.nix
    ./protonmail-bridge.nix
    ./protonvpn.nix
    ./qt.nix
    ./slack.nix
    ./sublime-music.nix
    ./sublime-text.nix
    ./thunderbird.nix
  ];
  xdg.portal.enable = true;
}
