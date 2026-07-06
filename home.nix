{ config, pkgs, inputs, ... }:

{
  imports = [
  	./dotfiles/modules/home/default.nix
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "26.05";
  home.file."Pictures/Wallpapers" = {source = ./dotfiles/assets/wallpapers; recursive = true; };


}
