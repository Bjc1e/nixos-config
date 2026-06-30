{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];
  programs.noctalia-shell.enable = true;
  
  systemd.user.services.noctalia = {
    Unit = {
      Description = "Noctalia Shell";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell";
      Restart = "always";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
