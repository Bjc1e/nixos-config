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

  programs.fish.enable = true;
  home.file.".config/fish" = {
	source = ./dotfiles/fish;
	recursive = true;
  };

  home.file.".config/kitty" = {
  	source = ./dotfiles/kitty;
	recursive = true;
  };

  home.file.".config/hypr" = {
	source = ./dotfiles/hypr;
	recursive = true;
  };

  home.file.".config/fastfetch" = {
	source = ./dotfiles/fastfetch;
	recursive = true;
  };

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
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -S hyprland-uwsm.desktop
      fi
    '';
  };
}
