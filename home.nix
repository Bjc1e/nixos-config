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
  
  programs.firefox = {
    enable = true;
    
    # Use policies to auto-install extensions globally
    policies = {
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # Popup Blocker (Strict)
        "strictpopups@mybrowseraddon.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/strict-pop-up-blocker/latest.xpi";
          installation_mode = "force_installed";
        };
        # New Tab Override (Required to bypass Firefox's new tab security)
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.ben = {
      isDefault = true;
      
      settings = {
        # Enforce Dark Theme across the UI, taskbar, and websites
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "ui.systemUsesDarkTheme" = 1;
        "browser.theme.content-theme" = 0; 
        "browser.theme.toolbar-theme" = 0;
        
        # Enable custom CSS for future glassy/transparent tweaks
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Harden Firefox's native built-in popup blocker
        "dom.disable_open_during_load" = true;
        "privacy.popups.showBrowserMessage" = false;
        
        # Set the default startup page (not new tab) to your home server
        "browser.startup.homepage" = "https://home.alkze.co.uk";
      };
    };
  };
}
