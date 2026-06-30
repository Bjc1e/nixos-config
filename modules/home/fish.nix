{ config, pkgs, ... }:

{
  # 1. Enable/Configure the program
  programs.fish = {
    enable = true;
    # Add any extra logic here, like shellInit or loginShellInit
  };

  # 2. Add extra data/packages if needed
  home.packages = with pkgs; [ fishPlugins.tide ];

  # 3. Create the symlink for the dotfiles
  home.file.".config/fish" = {
    source = ../../dotfiles/fish;
    recursive = true;
  };
}
