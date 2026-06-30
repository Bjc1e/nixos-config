{ config, pkgs, inputs, ... }:

{
  imports = [
  	./modules/home/default.nix
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "26.05";
  home.file."Pictures/Wallpapers" = {source = ./assets/wallpapers; recursive = true; };


}
