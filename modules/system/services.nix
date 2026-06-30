{ ... }:
{
  services.usbmuxd.enable = true;
  programs.steam.enable = true;

  # Hardware Services
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

}
