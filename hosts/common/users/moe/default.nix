{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.mutableUsers = false;
  users.users.moe = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ] ++ ifTheyExist [
      "network"
      "wireshark"
      "i2c"
      "podman"
      "git"
      "libvirtd"
    ];
    
    packages = [ pkgs.home-manager ];
  };

  home-manager.users.moe = import ../../../../home/moe/${config.networking.hostName}.nix;

  security.pam.services = { swaylock = { }; };
}
