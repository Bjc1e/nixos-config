{ pkgs, ... }:
{
  networking.hostName = "nixos";
  
  networking.networkmanager = {
    enable = true;
  };

  # Services that rely on network connectivity
  services.tailscale.enable = true;

  # Netbird & Stuff to make Netbird DNS work
  services.netbird.enable = true;
  services.resolved.enable = true;
  networking.firewall.trustedInterfaces = [ "wt0" ];
}
