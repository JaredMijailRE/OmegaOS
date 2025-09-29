{ config, pkgs, ... }:

{
  # Herramientas de desarrollo disponibles para todos los usuarios
  environment.systemPackages = with pkgs; [
    kitty
    git
    neovim
    # Cursor editor
    (pkgs.writeShellScriptBin "cursor" ''
      CURSOR_DIR="/opt/cursor"
      CURSOR_APPIMAGE="$CURSOR_DIR/cursor.appimage"
      
      mkdir -p "$CURSOR_DIR"
      
      if [ ! -f "$CURSOR_APPIMAGE" ]; then
        echo "Descargando Cursor..."
        curl -L "https://downloader.cursor.sh/linux/appImage/x64" -o "$CURSOR_APPIMAGE"
        chmod +x "$CURSOR_APPIMAGE"
      fi
      
      exec "$CURSOR_APPIMAGE" "$@"
    '')

    # Herramientas multimedia y teclas especiales
    pavucontrol
    brightnessctl
    playerctl
    acpi
    xorg.xev
    wmctrl
    swaylock

    nodejs
    docker
    go
    python3
    rustup
    cargo
    cargo-audit
    cargo-udeps
  ];
}