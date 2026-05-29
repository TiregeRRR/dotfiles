#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
STATE_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}"
BACKUP_ROOT="$STATE_ROOT/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
HYPR_STATE_DIR="$STATE_ROOT/hypr"
MONITORS_FILE="$HYPR_STATE_DIR/monitors.conf"
PACMAN_PACKAGES_FILE="$REPO_ROOT/packages/pacman.txt"
AUR_PACKAGES_FILE="$REPO_ROOT/packages/aur.txt"

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

SKIP_PACKAGES=0
SKIP_SERVICES=0
SKIP_SHELL=0
ROFI_BASE_CONFIG='@import "theme-generated.rasi"'

usage() {
  cat <<'EOF'
Usage: ./install.sh [options]

Options:
  --skip-packages  Do not install pacman/AUR packages
  --skip-services  Do not enable system services
  --skip-shell     Do not bootstrap oh-my-zsh
  -h, --help       Show this help
EOF
}

log() {
  printf '==> %s\n' "$*"
}

read_packages() {
  local file="$1"

  if [[ ! -f "$file" ]]; then
    return 0
  fi

  sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$file"
}

same_link() {
  local target="$1"
  local source="$2"

  [[ -L "$target" ]] && [[ "$(readlink -f "$target")" == "$(readlink -f "$source")" ]]
}

backup_target() {
  local target="$1"
  local relative="${target#"$HOME"/}"
  local backup_path="$BACKUP_ROOT/$relative"

  mkdir -p "$(dirname "$backup_path")"
  mv "$target" "$backup_path"
}

link_path() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  if same_link "$target" "$source"; then
    return 0
  fi

  if [[ -e "$target" || -L "$target" ]]; then
    log "Backing up $target -> $BACKUP_ROOT"
    backup_target "$target"
  fi

  ln -sfn "$source" "$target"
}

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    return 0
  fi

  local temp_dir
  temp_dir="$(mktemp -d)"

  log "Bootstrapping yay"
  git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
  (
    cd "$temp_dir/yay"
    makepkg -si --noconfirm
  )
  rm -rf "$temp_dir"
}

install_pacman_packages() {
  mapfile -t packages < <(read_packages "$PACMAN_PACKAGES_FILE")
  log "Installing pacman packages"
  sudo pacman -Syu --noconfirm --needed base-devel git curl wget "${packages[@]}"
}

install_aur_packages() {
  mapfile -t packages < <(read_packages "$AUR_PACKAGES_FILE")

  if (( ${#packages[@]} == 0 )); then
    return 0
  fi

  log "Installing AUR packages"
  yay -S --noconfirm --needed "${packages[@]}"
}

ensure_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    return 0
  fi

  log "Installing oh-my-zsh"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
}

link_dotfiles() {
  log "Linking dotfiles into \$HOME"

  for dir in "${CONFIG_DIRS[@]}"; do
    link_path "$REPO_ROOT/$dir" "$HOME/.config/$dir"
  done

  for file in "${HOME_FILES[@]}"; do
    link_path "$REPO_ROOT/$file" "$HOME/$file"
  done
}

prepare_runtime_dirs() {
  mkdir -p \
    "$HOME/.config/btop/themes" \
    "$HOME/.config/dunst" \
    "$HOME/.config/rofi" \
    "$HYPR_STATE_DIR" \
    "$STATE_ROOT/dotfiles" \
    "$HOME/.local/state/theme-switcher"
}

ensure_monitor_config() {
  touch "$MONITORS_FILE"
}

ensure_rofi_config() {
  local target="$HOME/.config/rofi/config.rasi"

  if [[ -f "$target" ]]; then
    return 0
  fi

  printf '%s\n' "$ROFI_BASE_CONFIG" > "$target"
}

apply_default_theme() {
  log "Generating theme-dependent config"
  "$HOME/.config/theme-switcher/apply-theme" --current
}

enable_services() {
  log "Enabling ly and NetworkManager"
  if systemctl list-unit-files 'ly@.service' --no-legend 2>/dev/null | grep -q '^ly@\.service'; then
    sudo systemctl disable getty@tty2.service >/dev/null 2>&1 || true
    sudo systemctl enable ly@tty2.service
  elif systemctl list-unit-files 'ly.service' --no-legend 2>/dev/null | grep -q '^ly\.service'; then
    sudo systemctl enable ly.service
  else
    log "Skipping ly: no matching systemd unit found"
  fi
  sudo systemctl enable NetworkManager.service
}

for arg in "$@"; do
  case "$arg" in
    --skip-packages)
      SKIP_PACKAGES=1
      ;;
    --skip-services)
      SKIP_SERVICES=1
      ;;
    --skip-shell)
      SKIP_SHELL=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$arg" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if ! command -v pacman >/dev/null 2>&1; then
  printf 'This installer targets Arch Linux and expects pacman.\n' >&2
  exit 1
fi

if (( SKIP_PACKAGES == 0 )); then
  install_pacman_packages
  ensure_yay
  install_aur_packages
fi

if (( SKIP_SHELL == 0 )); then
  ensure_oh_my_zsh
fi

link_dotfiles
prepare_runtime_dirs
ensure_monitor_config
ensure_rofi_config
apply_default_theme

if (( SKIP_SERVICES == 0 )); then
  enable_services
fi

log "Done. Backups, if any, are in $BACKUP_ROOT"
