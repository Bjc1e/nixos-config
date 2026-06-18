{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg)   [
    "mdk-sdk"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  boot.extraModulePackages = let
    kernel = config.boot.kernelPackages.kernel;
  in [
    (kernel.stdenv.mkDerivation {
      pname = "samsung-speaker-fix";
      version = "unstable";
      
      src = ./speaker-fix; 

      nativeBuildInputs = kernel.moduleBuildDependencies;

      buildPhase = ''
        find . -type f \( -name "*.c" -o -name "*.h" \) -exec cp {} . \;
        rm -f Makefile Kbuild dkms.conf
        
        # This is the exact step you missed! It explicitly glues the filter code 
        # to the main driver so the MODPOST linking error disappears.
        cat << 'EOF' > Makefile
        obj-m += snd-hda-scodec-max98390.o
        snd-hda-scodec-max98390-y := max98390_hda.o max98390_hda_filters.o
        
        obj-m += snd-hda-scodec-max98390-i2c.o
        snd-hda-scodec-max98390-i2c-y := max98390_hda_i2c.o
        EOF

        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
      '';

      installPhase = ''
        make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) INSTALL_MOD_PATH=$out modules_install
      '';
    })
  ];

  boot.kernelModules = [ 
    "snd-hda-scodec-max98390" 
    "snd-hda-scodec-max98390-i2c" 
  ];

  services.getty.autologinUser = "ben";

  services.tailscale.enable = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  time.timeZone = "Europe/London";

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment.pathsToLink = [ "share/xdg-desktop-portal" "share/applications" ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  users.users.ben = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.fish.enable = true;
  users.users.ben.shell = pkgs.fish;

  environment.systemPackages = with pkgs; [
    kitty
    fish
    chromium
    thunar
    fzf
    brightnessctl
    fastfetch
    neovim
    eza
    feishin
    fladder
    bibata-cursors
    pavucontrol
];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";

}
