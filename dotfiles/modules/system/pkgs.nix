{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    yazi
    fzf
    brightnessctl
    fastfetch
    neovim
    eza
    feishin
    fladder
    bibata-cursors
    tor-browser
    cifs-utils
    bat
    vlc
    (pkgs.symlinkJoin {
      name = "ferdium-wayland";
      paths = [ ferdium ];
      buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/ferdium \
          --add-flags "--ozone-platform=wayland --enable-features=WaylandWindowDecorations"
      '';
    })
    xwayland-satellite
  ];
}
