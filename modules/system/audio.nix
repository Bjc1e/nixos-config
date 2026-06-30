{ config, pkgs, ... }:
{
  # Audio Service Configuration
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Kernel Modules for Audio
  boot.kernelModules = [ 
    "snd-hda-scodec-max98390" 
    "snd-hda-scodec-max98390-i2c" 
  ];

  # Samsung Speaker Fix
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
}
