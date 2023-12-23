{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-hdd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/moe

    ../common/optional/greetd.nix
    ../common/optional/pipewire.nix
    ../common/optional/quietboot.nix
    ../common/optional/lol-acfix.nix
  ];

  networking = {
    hostName = "rusty";
    useDHCP = true;
  };

  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  hardware = {
    opengl.enable = true;
    opentabletdriver.enable = true;
  };

  system.stateVersion = "23.11";
}
