{ ... }:
{
  programs.git.enable = true;

  programs.git.aliases = {
    st = "status";
    co = "checkout";
    br = "branch";
    cm = "commit -m";
    lg = "log --graph --oneline --decorate --all";
    unstage = "restore --staged";
  };
}
