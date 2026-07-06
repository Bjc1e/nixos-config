{ pkgs, ... }: {
  programs.hyprland = { enable = true; withUWSM = true; xwayland.enable = true; };
  programs.niri.enable = true;
  environment.sessionVariables = {
    # This is the modern, global way to force Wayland for Electron
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # Optional: ensures that other toolkit-based apps try Wayland first
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
    config.common.default = "*";
  };
  environment.pathsToLink = [ "share/xdg-desktop-portal" "share/applications" ];
}
