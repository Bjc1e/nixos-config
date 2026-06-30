{ config, lib, pkgs, inputs, ... }:

# Importing my hardware config and anything else I choose
{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/system/default.nix
    ];

  # Allows non open source packages
  nixpkgs.config.allowUnfree = true;

  # Auto login
  services.getty.autologinUser = "ben";

  # Set timezone
  time.timeZone = "Europe/London";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";

}
