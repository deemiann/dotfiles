#!/usr/bin/env bash
# =====================================================================
# SCRIPT INTERNO DEL ENTORNO CHROOT
# =====================================================================
set -e

# Recibir y asignar las variables posicionales enviadas desde pre_install.sh
DISK="$1"
NUEVO_USUARIO="$2"
PASS_USUARIO="$3"
PASS_ROOT="$4"
ZONA_HORARIA="$5"
TECLADO="$6"
IDIOMA="$7"
LOCALE_LINE="$8"
HOSTNAME="$9"

echo "=== CHROOT: CONFIGURANDO ZONA HORARIA ==="
ln -sf "/usr/share/zoneinfo/$ZONA_HORARIA" /etc/localtime
hwclock --systohc

echo "=== CHROOT: CONFIGURANDO RED LOCAL ==="
echo "$HOSTNAME" > /etc/hostname

cat > /etc/hosts <<EOF
127.0.0.1 localhost
::1 localhost
127.0.1.1 ${HOSTNAME}.localdomain ${HOSTNAME}
EOF

echo "=== CHROOT: CONFIGURANDO IDIOMA Y TECLADO ==="
echo "KEYMAP=$TECLADO" > /etc/vconsole.conf
echo "LANG=$IDIOMA" > /etc/locale.conf

# Descomentar el locale exacto usando sed de forma segura
sed -i "s/#${LOCALE_LINE}/${LOCALE_LINE}/" /etc/locale.gen
locale-gen

echo "=== CHROOT: CONFIGURANDO CONTRASEÑAS NO INTERACTIVAS ==="
# Asignar contraseñas mediante tuberías y chpasswd
echo "root:$PASS_ROOT" | chpasswd

useradd -m "$NUEVO_USUARIO"
echo "$NUEVO_USUARIO:$PASS_USUARIO" | chpasswd

# Asignar grupos de sistema al usuario
usermod -aG wheel,audio,video,optical,storage "$NUEVO_USUARIO"

# Activar privilegios sudo de forma segura en /etc/sudoers para el grupo wheel
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel

echo "=== COPIANDO CONFIGURACIONES ==="

cp /dotfiles/src/to~/. /home/$NUEVO_USUARIO/ -a
mkdir -p /home/$NUEVO_USUARIO/.config
cp /dotfiles/src/to.config/* /home/$NUEVO_USUARIO/.config -r

mkdir -p /etc/X11/xorg.conf.d/
cp /dotfiles/src/toXorg.conf.d/* /etc/X11/xorg.conf.d/ -r

mkdir -p /home/$NUEVO_USUARIO/Images
cp /dotfiles/src/toImages/archlinux_logo.png /home/$NUEVO_USUARIO/Images
chown -R $NUEVO_USUARIO:$NUEVO_USUARIO /home/$NUEVO_USUARIO

echo "=== CHROOT: ACTIVANDO SERVICIOS DE RED ==="
systemctl enable NetworkManager.service

echo "=== CHROOT: INSTALANDO CARGADOR DE ARRANQUE GRUB ==="
# Nota: Apunta al disco físico base ($DISK) mapeado automáticamente
grub-install --target=x86_64-efi \
             --efi-directory=/boot/efi \
             --bootloader-id="Arch Linux" \
             --recheck \
             "$DISK"

grub-mkconfig -o /boot/grub/grub.cfg

echo "=== CHROOT: GENERANDO INITRAMFS ==="
mkinitcpio -P

echo "=== CHROOT: FINALIZADO ==="
exit 0

