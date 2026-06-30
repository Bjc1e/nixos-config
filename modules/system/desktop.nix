{ pkgs, ... }: {
  programs.hyprland = { enable = true; withUWSM = true; xwayland.enable = true; };
  programs.niri.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };
  environment.pathsToLink = [ "share/xdg-desktop-portal" "share/applications" ];
}
