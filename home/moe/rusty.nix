{ inputs, outputs, ... }: {
  imports = [
    ./global
    ./features/desktop/hyprland
    ./features/desktop/common/wayland-wm/mako.nix
    ./features/productivity
    ./features/games
    ./features/music
  ];

  colorscheme = inputs.nix-colors.colorschemes.paraiso;
  wallpaper = outputs.wallpapers.cyberpunk-city-red;

  monitors = [{
    name = "DP-1";
    width = 1920;
    height = 1080;
    workspace = "1";
    primary = true;
  }];
}
