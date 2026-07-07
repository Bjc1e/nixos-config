{ config, pkgs, ... }:

{
  # 1. Enable automatic optimization of the store on every build
  nix.settings.auto-optimise-store = true;

  # 2. Create a custom systemd service that runs exactly at boot time
  systemd.services.gc-on-boot = {
    description = "Clean up orphaned Nix store packages older than 3 days";
    
    # Ensure it only runs after the local file systems are ready
    after = [ "local-fs.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      # Run as root so it can clean both system-wide and user generations
      User = "root"; 
      
      # Step 1: Wipe profile generations older than 3 days
      # Step 2: Collect the garbage to free up the physical drive space
      ExecStart = pkgs.writeShellScript "gc-on-boot-script" ''
        echo "Wiping profile generations older than 3 days..."
        ${config.nix.package}/bin/nix-env --delete-generations 3d --profile /nix/var/nix/profiles/system
        
        echo "Running the garbage collector..."
        ${config.nix.package}/bin/nix-collect-garbage
      '';
    };
  };
}
