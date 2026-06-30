{ ... }:
{
  # If managing Hyprland via Home Manager
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    # Keep empty or add basic defaults
  };

  home.file.".config/hypr" = { source = ../../dotfiles/hypr; recursive = true; };
}
