# modules/desktop/librewolf.nix  (replaces the earlier draft)
{ inputs, lib, ... }:
{
  flake.modules.homeManager.librewolf = { pkgs, ... }:
    let
      addons = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.rycee.firefox-addons;

      arghavan-theme = inputs.arghavan.packages.${pkgs.stdenv.hostPlatform.system}.firefox-theme;
      
      readIfExists = p: lib.optionalString (builtins.pathExists p) (builtins.readFile p);

    in
    {
      # theming is the Arghavan extension theme, not Stylix
      stylix.targets.librewolf.enable = false;

      programs.librewolf = {
        enable = true;

        profiles.default = {
          id = 0;
          isDefault = true;

          settings = {
            # startup / UI
            "browser.startup.page" = 3;
            "browser.startup.homepage" = "http://localhost:8087/";
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.translations.neverTranslateLanguages" = "fa";
            "sidebar.visibility" = "hide-on-close";
            "sidebar.main.tools" = "";
            "ui.systemUsesDarkTheme" = 1;

            # theme + userChrome
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "extensions.activeThemeID" = "arghavan@dsam";
            "xpinstall.signatures.required" = false;
            "extensions.autoDisableScopes" = 0;

            # changed from LibreWolf defaults
            "privacy.sanitize.sanitizeOnShutdown" = false;
            "media.eme.enabled" = true;
            "security.enterprise_roots.enabled" = true;
            "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;

            # devtools
            "devtools.chrome.enabled" = true;
            "devtools.toolbox.host" = "right";
            "devtools.toolbox.selectedTool" = "netmonitor";
            "devtools.toolbox.splitconsole.open" = true;
          };

          extensions = {
            force = true;
            packages = [
              arghavan-theme
              addons.ublock-origin
              addons.privacy-badger
              addons.decentraleyes
              addons.foxyproxy-standard
              addons.stylus
              addons.spoof-timezone
              addons.user-agent-switcher-and-manager
              addons.sidebery
              addons.darkreader
              addons.new-tab-override
            ];
          };

          containersForce = true;
          containers = {
            Development = { id = 2; color = "green"; icon = "dollar"; };
            Iran = { id = 6; color = "orange"; icon = "tree"; };
            Proxied = { id = 10; color = "red"; icon = "fingerprint"; };
            Entertainment = { id = 11; color = "blue"; icon = "chill"; };
            "Social Media" = { id = 12; color = "pink"; icon = "briefcase"; };
          };

          userChrome = readIfExists ./librewolf-userChrome.css;
          userContent = readIfExists ./librewolf-userContent.css;
        };
      };
    };
}
