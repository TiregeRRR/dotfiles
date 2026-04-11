* {
  border: none;
  border-radius: 0;
  font-family: "__FONT_NERD__", "__FONT_MONO__", "JetBrainsMono Nerd Font", "JetBrainsMono NF";
  font-size: __FONT_WAYBAR_SIZE__px;
  min-height: 0;
  transition: none;
}

window#waybar {
  background: __BACKGROUND_CSS__;
  color: __FOREGROUND_CSS__;
}

tooltip {
  background: __BACKGROUND_CSS__;
  border: 1px solid __ACCENT_CSS__;
  color: __FOREGROUND_CSS__;
}

#workspaces {
  margin: 0;
}

#workspaces button {
  padding: 0 8px;
  margin: 0;
  min-width: 22px;
  color: __FOREGROUND_CSS__;
  background: transparent;
}

#workspaces button + button {
  border-left: 1px solid __ACCENT_CSS__;
}

#workspaces button:hover {
  background: __FOREGROUND_CSS__;
  color: __BACKGROUND_ALT_CSS__;
  box-shadow: none;
}

#workspaces button.visible {
  background: __FOREGROUND_CSS__;
  color: __BACKGROUND_ALT_CSS__;
}

#workspaces button.active,
#workspaces button.focused {
  background: __ACCENT_CSS__;
  color: __BACKGROUND_ALT_CSS__;
}

#workspaces button.urgent {
  background: __ACCENT_ALT_CSS__;
  color: __BACKGROUND_ALT_CSS__;
}

#window {
  padding: 0 10px;
  color: __FOREGROUND_CSS__;
}

#custom-now-playing {
  padding: 0 10px;
  background: __ACCENT_CSS__;
  color: __BACKGROUND_ALT_CSS__;
  font-weight: 600;
}

#tray {
  padding: 0 8px 0 0;
}

#custom-tray-sep,
#disk,
#pulseaudio,
#language,
#memory,
#cpu,
#network,
#clock {
  padding: 0;
  margin: 0;
}

#pulseaudio.muted,
#network.disconnected {
  color: __FOREGROUND_CSS__;
}
