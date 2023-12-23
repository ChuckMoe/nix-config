{
  boot = {
    kernelModules = [ "kvm-amd" ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "ohci_pci" "pata_atiixp" "uns_realtek" "usbhid" "usb_storage" "sd_mod" "sr_nod" ];
      kernelModules = [ ];
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    extraModulePackages = [ ];
  };
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6f65f943-afbb-458f-9218-24b059c4bb88";
      fsType = "ext4";
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/3090-AB66";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/dev/disk/by-uuid/dfee7456-5233-4694-94d8-689f2e8cf281";
  }];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = true;
}
