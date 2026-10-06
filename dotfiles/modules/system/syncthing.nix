{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "ben";
    dataDir = "/home/ben/ObsidianVault";
    configDir = "/home/ben/.config/syncthing";

    # Enforce declarative configuration
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "alpine-ct" = {
          # Device ID from screenshot[cite: 1]
          id = "YZGMGK5-2V676B4-LUJIGRK-VXHWKZN-YCJS43L-SSMI5L3-XORHAOW-H2UTVQ5";
          addresses = [ "tcp://11.0.0.7:22000" ];
        };
      };

      folders = {
        "obsidian-vault" = {
          path = "/home/ben/ObsidianVault";
          devices = [ "alpine-ct" ];
          type = "sendreceive";

          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };

          ignorePatterns = [
            ".obsidian/workspace.json"
            ".obsidian/workspace-mobile.json"
            ".obsidian/cache"
            ".obsidian/backups"
            "(?d).DS_Store"
            "(?d)Thumbs.db"
            "(?d)._*"
          ];
        };
      };
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 8384 ];
    allowedUDPPorts = [ 22000 21027 ];
  };
}
