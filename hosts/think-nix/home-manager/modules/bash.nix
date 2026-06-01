{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      switch = "sudo nixos-rebuild switch";
      home-switch = "home-manager switch";
    };
  };
}
