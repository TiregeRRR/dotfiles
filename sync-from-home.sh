#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_DIRS=(
  alacritty
  doom
  hypr
  i3
  lvim
  nvim
  picom
  polybar
  rofi
  theme-switcher
)

HOME_FILES=(
  .Xresources
  .xinitrc
  .zshrc
)

log() {
  printf '==> %s\n' "$*"
}

same_path() {
  local left="$1"
  local right="$2"

  [[ -e "$left" || -L "$left" ]] && [[ -e "$right" || -L "$right" ]] && [[ "$(readlink -f "$left")" == "$(readlink -f "$right")" ]]
}

sync_config_dir() {
  local rel="$1"
  local source="$HOME/.config/$rel"
  local target="$REPO_ROOT/$rel"
  local -a excludes=(
    --exclude '__pycache__'
    --exclude '*.pyc'
  )

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    log "Skipping $source (missing)"
    return 0
  fi

  if same_path "$source" "$target"; then
    log "Skipping $rel (already points to repo)"
    return 0
  fi

  case "$rel" in
    alacritty)
      excludes+=(--exclude 'font-generated.toml' --exclude 'theme-generated.toml')
      ;;
    hypr)
      excludes+=(
        --exclude 'hyprlock.conf'
        --exclude 'hyprpaper.conf'
        --exclude 'theme/current.conf'
        --exclude 'wallpaper.png'
        --exclude 'waybar.css'
        --exclude 'waybar.jsonc'
      )
      ;;
    nvim)
      excludes+=(--exclude 'lua/theme/generated.lua')
      ;;
    rofi)
      excludes+=(--exclude 'theme-generated.rasi')
      ;;
    theme-switcher)
      excludes+=(
        --exclude 'current_font'
        --exclude 'current_theme'
      )
      ;;
  esac

  mkdir -p "$target"
  log "Syncing $source -> $target"
  rsync -a --delete "${excludes[@]}" "$source/" "$target/"
}

sync_home_file() {
  local rel="$1"
  local source="$HOME/$rel"
  local target="$REPO_ROOT/$rel"

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    log "Skipping $source (missing)"
    return 0
  fi

  if same_path "$source" "$target"; then
    log "Skipping $rel (already points to repo)"
    return 0
  fi

  log "Syncing $source -> $target"
  rsync -a "$source" "$target"
}

for dir in "${CONFIG_DIRS[@]}"; do
  sync_config_dir "$dir"
done

for file in "${HOME_FILES[@]}"; do
  sync_home_file "$file"
done

log "Sync complete"
git -C "$REPO_ROOT" status --short
