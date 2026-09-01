{ user, ... }:
{
  imports = [
    ../../profiles/server.nix
    ./boot.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  users = {
    users.${user} = {
      hashedPassword = "!";
      openssh.authorizedKeys.keyFiles = [
        ../../keys/mitchanx-think-nix.pub
        ../../keys/nugget.pub
      ];
      extraGroups = [ "video" "render" ];
    };
  };

  networking = {
    useDHCP = false;
    interfaces = {
      eth0.ipv4.addresses = [
        { address = "192.168.2.53"; prefixLength = 24; }
        { address = "192.168.2.54"; prefixLength = 24; }
      ];
    };
    defaultGateway = "192.168.2.1";
    nameservers = [ "192.168.2.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 22 ];
      checkReversePath = false; 
    };
  };

  system.stateVersion = "25.11";
}
