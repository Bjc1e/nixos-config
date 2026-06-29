{ config, pkgs, inputs, ... }:

{
  imports = [
	inputs.noctalia.homeModules.default
  ];

  home.username = "ben";
  home.homeDirectory = "/home/ben";
  home.stateVersion = "26.05";

  programs.noctalia-shell = {
   	enable = true;
 	# settings = { ... };
  };

  home.file."Pictures/Wallpapers" = {source = ./assets/wallpapers; recursive = true; };
  home.file.".config/fish" = { source = ./dotfiles/fish; recursive = true; };
  home.file.".config/kitty" = { source = ./dotfiles/kitty; recursive = true; };
  home.file.".config/hypr" = { source = ./dotfiles/hypr; recursive = true; };
  home.file.".config/fastfetch" = { source = ./dotfiles/fastfetch; recursive = true; };
  home.file.".config/niri" = { source = ./dotfiles/niri; recursive = true; };

  systemd.user.services.noctalia = {
	Unit = {
		Description = "Noctalia Shell";
		PartOf = [ "graphical-session.target" ];
		After = [ "graphical-session.target" ];
	};
	Service = {
		ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell";
		Restart = "always";
	};
	Install = {
		WantedBy = [ "graphical-session.target" ];
	};
  };

  programs.git.enable = true;

}
