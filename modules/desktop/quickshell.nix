{ config, lib, ... }:
let
  colors = config.meta.colors;
in
{
  flake.modules.homeManager.quickshell = { pkgs, ... }:
    let
      # Palette from config.meta.colors, exposed to QML as the Theme singleton
      theme = pkgs.writeText "Theme.qml" ''
        pragma Singleton
        import QtQuick
        import Quickshell

        Singleton {
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList
          (name: value: "    readonly property color ${name}: \"${value}\"") colors)}

            readonly property string fontFamily: "Maple Mono NF"
            readonly property int fontSize: 15
        }
      '';

      shell = pkgs.runCommandLocal "saman-quickshell" { } ''
        mkdir -p $out
        cp -r --no-preserve=mode ${./quickshell}/. $out/
        cp ${theme} $out/Theme.qml
      '';
    in
    {
      home.packages = [ pkgs.brightnessctl ];

      # replace sway's default swaybar
      wayland.windowManager.sway.config.bars = [ ];

      # mkOptionDefault keeps the default sway keybindings; a plain definition would replace them all
      wayland.windowManager.sway.config.keybindings = lib.mkOptionDefault {
        # replaces the default swaynag exit prompt
        "Mod4+Shift+e" = lib.mkForce "exec qs ipc -c saman call session confirmExit";
        "Mod4+Shift+p" = "exec qs ipc -c saman call session menu";
      };

      programs.quickshell = {
        enable = true;
        systemd.enable = true;
        configs.saman = shell;
        activeConfig = "saman";
      };

      # stop and start with the session, so a new login gets a fresh instance
      systemd.user.services.quickshell.Unit.PartOf = [ "graphical-session.target" ];
    };
}
