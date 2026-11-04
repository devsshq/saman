{
  flake.modules.homeManager.waybar = { pkgs, ... }: {
    home.packages = with pkgs; [ pamixer brightnessctl ];

    # Stylix's generated CSS would merge into yours
    stylix.targets.waybar.enable = false;

    # replace sway's default swaybar
    wayland.windowManager.sway.config.bars = [ ];

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ./waybar.css;

      settings.mainBar = {
        height = 36;
        layer = "top";
        position = "top";
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [ "sway/workspaces" "sway/mode" "custom/divider" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray" "custom/divider" "backlight" "pulseaudio#microphone"
          "pulseaudio" "network" "battery"
        ];

        "sway/workspaces".disable-scroll = true;

        "sway/window" = {
          tooltip = false;
          icon = true;
          icon-size = 20;
        };

        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          on-scroll-up = "brightnessctl set 10%+";
          on-scroll-down = "brightnessctl set 10%-";
        };

        pulseaudio = {
          tooltip = false;
          format = "{icon} {volume}%";
          format-muted = " Muted";
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          format-icons = {
            headset = "";
            headphone = "";
            default = [ "" "" "" ];
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = " Muted";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 1;
        };

        network = {
          interface = "wlo1";
          tooltip = true;
          tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>";
          format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
          format-wifi = "  {ipaddr}/{cidr}";
          format-ethernet = "{ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
        };

        battery = {
          states = { good = 95; warning = 30; critical = 20; };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#b6beca'><b>{}</b></span>";
              weekdays = "<span color='#75aaf0'><b>{}</b></span>";
              today = "<span color='#e05f65'><b>{}</b></span>";
            };
          };
        };

        tray = {
          icon-size = 20;
          spacing = 10;
          show-passive-items = true;
        };

        "custom/divider".format = "|";
      };
    };
  };
}
