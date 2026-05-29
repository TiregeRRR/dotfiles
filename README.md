# dotfiles

Arch Linux dotfiles with a Hyprland-first setup, theme switching, and a single bootstrap entrypoint.

## What is in here

- `hypr/` - current Hyprland config, bindings, wallpaper and Waybar now-playing helper
- `hypr/` also contains the PostLink log watcher that feeds desktop notifications
- `theme-switcher/` - theme/font generator for Hyprland, Hyprlock, Hyprpaper, Waybar, Rofi, Alacritty, Neovim, Dunst, btop, Firefox and VS Code family
- `nvim/` - Neovim config wired into the generated desktop theme
- `alacritty/`, `rofi/` - base configs that import generated theme fragments
- legacy configs like `i3/`, `picom/`, `polybar/`, `doom/`, `lvim/` are still kept in the repo

## Bootstrap

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer:

- installs Arch packages from [`packages/pacman.txt`](packages/pacman.txt)
- bootstraps `yay` if it is missing
- symlinks the tracked dotfiles into `~/.config` and `~`
- ensures `~/.config/rofi/config.rasi` exists before first theme generation
- generates theme-dependent config via `theme-switcher`
- enables `ly@tty2.service` when the unit exists, plus `NetworkManager`
- backs up replaced files into `~/.local/state/dotfiles/backups/`

Useful flags:

```bash
./install.sh --skip-packages
./install.sh --skip-services
./install.sh --skip-shell
```

## Sync Back From Home

If you changed files directly in `~/.config` or in `~`, sync them back into the repo with:

```bash
cd ~/dotfiles
./sync-from-home.sh
```

The script skips generated files like `hyprlock.conf`, `waybar.css`, `theme-generated.toml` and `nvim/lua/theme/generated.lua`, so it only pulls back the source files you should actually version.

## Theme Switching

After install:

- `Super+Shift+T` opens the theme picker
- `Super+Shift+F` opens the font picker
- `~/.config/theme-switcher/apply-theme --list` lists themes
- `~/.config/theme-switcher/apply-font --list` lists font presets

Defaults are stored in:

- [`theme-switcher/default_theme`](theme-switcher/default_theme)
- [`theme-switcher/default_font`](theme-switcher/default_font)

Current selections are stored outside git in `~/.local/state/theme-switcher/`.

## Notes

- The repo is currently opinionated for Arch Linux.
- GPU drivers are intentionally not managed by the installer; keep hardware-specific driver setup separate.
- Theme-generated files are ignored in git, so changing theme/font does not pollute the worktree.
