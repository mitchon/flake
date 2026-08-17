{
  nixpkgs.overlays = [
    (_final: prev: {
      steam = prev.steam.override {
        extraArgs = "-cef-disable-gpu-compositing";
      };
    })
  ];

  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };
}
