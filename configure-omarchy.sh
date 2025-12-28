#!/usr/bin/env bash
set -euo pipefail

PACKAGES=(
  "omarchy"
  "starship"
  # more packages
)

# List of targets (relative to $TARGET_HOME) that your stow package will provide.
# Add/remove paths here as needed.
TARGETS=(
  ".config/hypr/monitors.conf"
  ".config/hypr/bindings.conf"
  ".config/wireplumber/wireplumber.conf.d/51-disable-monitor-audio.conf"
  ".config/starship.toml"
  # more files
)

die() { echo "Error: $*" >&2; exit 1; }
info() { echo "• $*"; }
warn() { echo "⚠ $*" >&2; }

run() {
  if [[ "${DRY_RUN:-0}" == "1" ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# Require sudo
if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  echo "Error: Please run this script with sudo (e.g. sudo $0)" >&2
  exit 1
fi

# Figure out the "real" user home when running via sudo
if [[ -n "${SUDO_USER:-}" ]]; then
  TARGET_HOME="$(eval echo "~$SUDO_USER")"
else
  TARGET_HOME="$HOME"
fi

# --- 1) Check stow installed -------------------------------------------------
command -v stow >/dev/null 2>&1 || die "GNU Stow is not installed.
Please install it first, then re-run this script.
See README.md for more information."

# --- 2) Enforce we're in the dotfiles repo root ------------------------------
DOTFILES_DIR="$(pwd)"

[[ "$(basename "$DOTFILES_DIR")" == "dotfiles" ]] || die "You must run this script from your dotfiles repo root.
Expected current directory to be named 'dotfiles', but got: $DOTFILES_DIR
(cd into ~/dotfiles and run it there)"

# Validate packages exist
for pkg in "${PACKAGES[@]}"; do
  [[ -n "$pkg" ]] || continue
  [[ -d "$DOTFILES_DIR/$pkg" ]] || die "Package '$pkg' not found at: $DOTFILES_DIR/$pkg
Make sure you're in the dotfiles root and that './$pkg' exists."
done

# --- 3) Pre-clean targets (files only; never remove dirs) --------------------
info "Pre-cleaning targets (only removing non-symlink files; never removing directories)..."

for rel in "${TARGETS[@]}"; do
  target="$TARGET_HOME/$rel"

  # If it's already a symlink, keep it
  if [[ -L "$target" ]]; then
    info "Keep (already symlink): $target"
    continue
  fi

  # If it's a regular file, remove it
  if [[ -f "$target" ]]; then
    info "Remove file: $target"
    run rm -f -- "$target"
    continue
  fi

  # If it's a directory (or anything else), do nothing
  if [[ -d "$target" ]]; then
    info "Keep (directory): $target"
    continue
  fi

  info "Not present: $target"
done

# --- 4) Run stow -------------------------------------------------------------
for pkg in "${PACKAGES[@]}"; do
  [[ -n "$pkg" ]] || continue
  info "Stowing package '$pkg' from: $DOTFILES_DIR"
  run stow -d "$DOTFILES_DIR" -t "$TARGET_HOME" "$pkg"
done

# --- 5) Reload Hyprland ------------------------------------------------------
reload_hyprland() {
  local user="${SUDO_USER:-$USER}"
  local uid
  uid="$(id -u "$user")"
  local xdg_runtime="/run/user/$uid"

  # If we're not in a Hyprland session, don't fail the script.
  command -v hyprctl >/dev/null 2>&1 || { warn "hyprctl not found; skip Hyprland reload"; return 0; }
  [[ -d "$xdg_runtime" ]] || { warn "No $xdg_runtime; skip Hyprland reload"; return 0; }

  # If sudo stripped HYPRLAND_INSTANCE_SIGNATURE, detect it from runtime dir.
  local sig="${HYPRLAND_INSTANCE_SIGNATURE:-}"
  if [[ -z "$sig" && -d "$xdg_runtime/hypr" ]]; then
    sig="$(ls -1 "$xdg_runtime/hypr" 2>/dev/null | head -n 1 || true)"
  fi

  if [[ -z "$sig" ]]; then
    warn "Could not determine HYPRLAND_INSTANCE_SIGNATURE; skip Hyprland reload"
    return 0
  fi

  info "Reloading Hyprland config..."
  run sudo -u "$user" env \
    XDG_RUNTIME_DIR="$xdg_runtime" \
    HYPRLAND_INSTANCE_SIGNATURE="$sig" \
    hyprctl reload || warn "Hyprland reload failed (not in session?)"
}

reload_hyprland

info "Done."
