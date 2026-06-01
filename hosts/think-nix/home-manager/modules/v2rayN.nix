{ pkgs, ...}:
{
  xdg.dataFile = {
    "v2rayN/bin/sing_box/sing-box" = {
      source = "${pkgs.sing-box}/bin/sing-box";
      force = true;
    };
    "v2rayN/bin/xray/xray" = {
      source = "${pkgs.xray}/bin/xray";
      force = true;
    };
  };
}
