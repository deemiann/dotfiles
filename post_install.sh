#!/usr/bin/env bash
# =====================================================================
# SCRIPT DE POST-INSTALACIÓN - ENTORNO GRÁFICO Y DOTFILES
# =====================================================================
set -e

echo "=== 1. INSTALANDO ENTORNO GRÁFICO Y AUDIO ==="
sudo pacman -S --noconfirm intel-ucode xorg-server xorg-xinit mesa \
    i3-wm dmenu feh alacritty ttf-dejavu firefox pipewire pipewire-alsa \
    pipewire-pulse wireplumber \

echo "=== 5. COPIANDO CONFIGURACIONES (~) ==="
cp src/.bashrc "$HOME/"
cp src/.vimrc "$HOME/"

echo "=== 6. COPIANDO CONFIGURACIONES A MDE (~/.config) ==="
mkdir -p "$HOME/.config"
cp -r .config/* "$HOME/.config/"

echo "=== 7. CONFIGURANDO TECLADO Y PANEL TÁCTIL (XORG) ==="
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo cp src/20-keyboard.conf /etc/X11/xorg.conf.d/
sudo cp src/30-touchpad.conf /etc/X11/xorg.conf.d/

echo "=== 8. CREANDO CARPETA DE IMÁGENES Y FONDO DE PANTALLA ==="
mkdir -p "$HOME/Images"
cp src/archlinux_logo.png "$HOME/Images/"

echo "====================================================================="
echo "¡ENTORNO CONFIGURADO CON ÉXITO!"
echo "====================================================================="
