{ user, ... }:
{
  imports = [
    ../../profiles/server.nix
    ./boot.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  users = {
    groups.${user}.gid = 1000;
    users.${user} = {
      uid = 1000;
      group = user;
      hashedPassword = "!";
      openssh.authorizedKeys.keyFiles = [
        ../../keys/mitchanx-think-nix.pub
        ../../keys/nugget.pub
      ];
    };
  };

  networking = {
    useDHCP = false;
    interfaces = {
      eth0.ipv4.addresses = [{
        address = "192.168.2.53";
        prefixLength = 24;
      }];
      eth1.ipv4.addresses = [{
        address = "192.168.2.54";
        prefixLength = 24;
      }];
    };
    defaultGateway = "192.168.2.1";
    nameservers = [ "192.168.2.1" ];
  };

  system.stateVersion = "25.11";
}
