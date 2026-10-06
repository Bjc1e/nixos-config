{ config, pkgs, ... }:

{
  boot.kernelModules = [ "vkms" "uinput" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-utils
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    sunshine
    libva-utils
  ];

  users.users.ben.extraGroups = [ "uinput" "input" "video" "render" ];
}
