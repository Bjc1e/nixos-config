{ pkgs, inputs, ... }: {
  users.users.ben = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" ];
    shell = pkgs.fish; # Moved shell here
    packages = with pkgs; [ tree inputs.iloader.packages.${pkgs.system}.default ];
  };
  programs.fish.enable = true;
  services.getty.autologinUser = "ben";
}
