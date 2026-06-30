{ ... }:
{
  programs.fastfetch.enable = true;
  home.file.".config/fastfetch" = { source = ../../dotfiles/fastfetch; recursive = true; };
}
