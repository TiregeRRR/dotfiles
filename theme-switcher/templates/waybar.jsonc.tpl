[
  {
    "layer": "top",
    "position": "bottom",
    "exclusive": true,
    "height": 24,
    "spacing": 0,
    "modules-left": [
      "hyprland/workspaces",
      "hyprland/window"
    ],
    "modules-center": [
      "custom/now-playing"
    ],
    "modules-right": [
      "tray",
      "custom/tray-sep",
      "disk",
      "pulseaudio",
      "hyprland/language",
      "memory",
      "cpu",
      "network#wlan",
      "network#eth",
      "clock",
      "custom/quick-settings"
    ],
    "hyprland/workspaces": {
      "all-outputs": false,
      "disable-scroll": true,
      "move-to-monitor": true,
      "format": "{id}",
      "sort-by": "number"
    },
    "hyprland/window": {
      "format": "{}",
      "max-length": 60,
      "tooltip": false,
      "on-scroll-up": "hyprctl dispatch workspace e-1",
      "on-scroll-down": "hyprctl dispatch workspace e+1"
    },
    "custom/now-playing": {
      "exec": "python3 /home/utsuro/.config/hypr/waybar-now-playing.py",
      "return-type": "json",
      "interval": 0.3,
      "format": "{text}",
      "on-click": "playerctl -p playerctld play-pause",
      "on-click-middle": "playerctld unshift",
      "on-click-right": "playerctld shift",
      "on-scroll-up": "playerctl -p playerctld previous",
      "on-scroll-down": "playerctl -p playerctld next",
      "tooltip": true
    },
    "tray": {
      "spacing": 16
    },
    "custom/tray-sep": {
      "format": "<span foreground='__ACCENT_CSS__'> | </span>",
      "tooltip": false
    },
    "disk": {
      "interval": 25,
      "path": "/",
      "format": "<span foreground='__WARNING_CSS__'>{path}</span> {percentage_used}%<span foreground='__ACCENT_CSS__'> | </span>",
      "tooltip": false
    },
    "pulseaudio": {
      "scroll-step": 5,
      "format": "<span foreground='__ACCENT_CSS__'>VOL </span>{volume}%<span foreground='__ACCENT_CSS__'> | </span>",
      "format-muted": "<span foreground='__ACCENT_CSS__'>VOL </span>muted<span foreground='__ACCENT_CSS__'> | </span>",
      "format-bluetooth": "<span foreground='__ACCENT_CSS__'>VOL </span>{volume}%<span foreground='__ACCENT_CSS__'> | </span>",
      "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
      "on-click-right": "pavucontrol",
      "tooltip": false
    },
    "hyprland/language": {
      "format": "<span foreground='__ACCENT_CSS__'>{short}</span><span foreground='__ACCENT_CSS__'> | </span>"
    },
    "memory": {
      "interval": 2,
      "format": "<span foreground='__ACCENT_CSS__'>RAM </span>{percentage}%<span foreground='__ACCENT_CSS__'> | </span>",
      "tooltip": false
    },
    "cpu": {
      "interval": 2,
      "format": "<span foreground='__ACCENT_CSS__'>CPU </span>{usage}%<span foreground='__ACCENT_CSS__'> | </span>",
      "tooltip": false
    },
    "network#wlan": {
      "interface": "wl*",
      "interval": 5,
      "format-wifi": "<span foreground='__WARNING_CSS__'>{ifname}</span> {essid} {ipaddr}<span foreground='__ACCENT_CSS__'> | </span>",
      "format-linked": "<span foreground='__WARNING_CSS__'>{ifname}</span> no-ip<span foreground='__ACCENT_CSS__'> | </span>",
      "format-disconnected": "",
      "format-disabled": "",
      "tooltip": false
    },
    "network#eth": {
      "interface": "en*",
      "interval": 5,
      "format-ethernet": "<span foreground='__WARNING_CSS__'>{ifname}</span> {ipaddr}<span foreground='__ACCENT_CSS__'> | </span>",
      "format-linked": "<span foreground='__WARNING_CSS__'>{ifname}</span> no-ip<span foreground='__ACCENT_CSS__'> | </span>",
      "format-disconnected": "",
      "tooltip": false
    },
    "clock": {
      "interval": 1,
      "format": "<span foreground='__ACCENT_CSS__'>{:%Y-%m-%d %H:%M:%S}</span>",
      "tooltip": false
    },
    "custom/quick-settings": {
      "exec": "/home/utsuro/.config/hypr/quick-settings-menu --label",
      "interval": 3600,
      "format": "{}",
      "tooltip": false,
      "on-click": "/home/utsuro/.config/hypr/quick-settings-menu"
    }
  }
]
