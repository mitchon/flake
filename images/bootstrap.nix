{
  config,
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot.loader.timeout = lib.mkForce 1;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  image.baseName = lib.mkForce "nixos-bootstrap-${config.system.stateVersion}-${pkgs.stdenv.hostPlatform.system}";
  isoImage = {
    makeEfiBootable = true;
    makeUsbBootable = true;
    squashfsCompression = "xz -b 1M -Xdict-size 100%";
  };

  networking = {
    hostName = "nixos-bootstrap";
    firewall.enable = false;
    useNetworkd = true;
  };
  systemd.network.enable = true;

  environment.defaultPackages = lib.mkForce [ ];
  environment.systemPackages = [
    pkgs.git
    inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  services.cloud-init = {
    enable = true;
    network.enable = true;
    settings.datasource_list = [ "NoCloud" ];
  };

  services.qemuGuest.enable = true;

  services.getty.autologinUser = lib.mkForce "root";
  systemd.services.sshd = {
    wants = [ "network-online.target" ];
    after = [
      "cloud-init.target"
      "network-online.target"
    ];
  };
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
    };
  };
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ../keys/mitchanx-think-nix.pub
  ];

  programs.command-not-found.enable = false;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
  };

  system.stateVersion = "25.11";
}
