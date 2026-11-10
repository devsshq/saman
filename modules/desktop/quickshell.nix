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

      programs.quickshell = {
        enable = true;
        systemd.enable = true;
        configs.saman = shell;
        activeConfig = "saman";
      };
    };
}
