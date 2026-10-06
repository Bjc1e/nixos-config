{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  fileSystems."/home/ben/NFS" = {
    device = "11.0.0.4:/shared"; # Replace '/shared' with your actual remote NFS export path
    fsType = "nfs";
    options = [
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "noauto"
    ];
  };
}
