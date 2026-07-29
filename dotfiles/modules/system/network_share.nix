{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/network_drive" = {
    device = "//192.168.0.72/data";
    fsType = "cifs";
    options = let
      # Prevent system hangs if the network is unavailable
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/.smb-secrets,uid=1000,gid=100"];
  };
}
