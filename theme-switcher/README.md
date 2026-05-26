# Theme Switcher

Quick theme switching for:

- Hyprland
- Hyprlock
- Hyprpaper
- Waybar
- Rofi
- Alacritty
- Neovim
- Dunst
- btop
- k9s
- Firefox
- VS Code family

## Usage

Apply a theme directly:

```sh
~/.config/theme-switcher/apply-theme tokyonight
~/.config/theme-switcher/apply-theme tokyonight-storm
~/.config/theme-switcher/apply-theme tokyonight-moon
~/.config/theme-switcher/apply-theme gruvbox
~/.config/theme-switcher/apply-theme nord
~/.config/theme-switcher/apply-theme rosepine
~/.config/theme-switcher/apply-theme kanagawa-wave
~/.config/theme-switcher/apply-theme kanagawa-dragon
```

Change the current font preset:

```sh
~/.config/theme-switcher/apply-font pixel-code
~/.config/theme-switcher/apply-font jetbrains
~/.config/theme-switcher/apply-font hack
~/.config/theme-switcher/apply-font ubuntu
```

Open the chooser:

```sh
~/.config/theme-switcher/theme-menu
~/.config/theme-switcher/font-menu
```

Inside Hyprland it is also bound to `Super+Shift+T` for themes and `Super+Shift+F` for fonts.

The tracked defaults live in `default_theme` and `default_font`. The active selection is stored outside git in `~/.local/state/theme-switcher/`.

## Runtime behavior

- `Hyprland`, `Waybar`, `Hyprpaper`, `Rofi` and `Dunst` are regenerated immediately.
- `btop` gets a generated `theme-switcher.theme`; new btop launches pick it up automatically.
- `k9s` gets a generated skin in `~/.config/k9s/skins/theme-switcher.yaml`; restart `k9s` if it is already running.
- `Alacritty` reads `theme-generated.toml` via `import` and reloads through its live config reload.
- `Neovim` reads `lua/theme/generated.lua`; open sessions refresh the colorscheme when they regain focus.
- `Firefox` gets generated `userChrome.css` / `userContent.css` and a `user.js` block; browser restart is required.
- `Code`, `Cursor` and `VSCodium` get merged `settings.json` color overrides for workbench, editor and integrated terminal.
- Font presets override the theme defaults for UI, mono and bar fonts.
- `wallpaper` in `themes/*.json` can be either an absolute path or a path relative to `~/.config/theme-switcher/`.

## Add a new theme

1. Copy one of the files in `~/.config/theme-switcher/themes/`.
2. Change the colors and wallpaper path.
3. Run `~/.config/theme-switcher/apply-theme <theme-id>`.

## File layout

- `themes/*.json` - color presets
- `wallpapers/*` - bundled wallpapers matched to the included themes
- `fonts/*.json` - font presets
- `templates/*` - source templates
- `apply-theme` - generates live config files and reloads apps
- `apply-font` - switches the current font preset and reapplies the current theme
- `theme-menu` - rofi-based selector
- `font-menu` - rofi-based font selector
