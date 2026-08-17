{
  hostname,
  user,
  ...
}:

{
  imports = [
    ../../profiles/server.nix
    ./boot.nix
    ./disko-configuration.nix
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  users = {
    groups.${user}.gid = 1000;
    users.${user} = {
      uid = 1000;
      group = user;
      hashedPassword = "!";
      openssh.authorizedKeys.keyFiles = [
        ../../../keys/mitchanx-think-nix.pub
        ../../../keys/nugget.pub
      ];
    };
  };

  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "25.11";
}
