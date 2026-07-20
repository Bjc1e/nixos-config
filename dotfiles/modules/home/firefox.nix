{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.ben = {
      isDefault = true;
      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "ui.systemUsesDarkTheme" = 1;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        # Reverted to default homepage by omitting "browser.startup.homepage"
      };
    };
  };
}
