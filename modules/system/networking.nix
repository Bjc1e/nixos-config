{ ... }:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # Services that rely on network connectivity
  services.tailscale.enable = true;
}
