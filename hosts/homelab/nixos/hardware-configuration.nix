{
  lib,
  modulesPath,
  user,
  ...
}:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sd_mod"
    "sr_mod"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
  ];

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/2eeedad6-fb5e-434e-a6a0-f340f7503eb1";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
      "nofail"
    ];
    neededForBoot = false;
  };

  systemd.tmpfiles.rules = [
    "d /mnt/hdd 0755 ${user} users - -"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
