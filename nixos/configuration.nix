{ stateVersion, hostname, user, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  boot.kernelModules = [ "i2c-dev" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = hostname;

  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
  };

  time.timeZone = "Europe/Moscow";

  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  services.libinput.enable = true;
  services.dbus.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "i2c-rules";
      destination = "/etc/udev/rules.d/70-i2c.rules";
      text = ''
        ACTION=="add", KERNEL=="i2c-[0-9]*", TAG+="uaccess", GROUP="i2c", MODE="0660"
      '';
    })
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember-session --user-menu --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "i2c" "docker" ];
  };

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    libnotify
    # xdg-desktop-portal-gnome
    alacritty
    xwayland-satellite
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    ddcutil
    bluez
    adwaita-icon-theme
    home-manager
    nautilus
    v2rayn
    sing-box
  ];

  networking.firewall.allowedUDPPorts = [ 53 ];
  # networking.networkmanager.dns = "none";
  # networking.networkmanager.appendNameservers = [ "1.1.1.1" "8.8.8.8" ];
  
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.fira-code
  ];

  system.stateVersion = stateVersion;

}
