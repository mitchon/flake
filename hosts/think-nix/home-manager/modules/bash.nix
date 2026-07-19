{
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      switch = "sudo nixos-rebuild switch --flake /home/mitchanx/flake#think-nix";
      home-switch = "home-manager switch --flake /home/mitchanx/flake#think-nix";
    };
  };
}
