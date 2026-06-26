#!/usr/bin/env bash
# =====================================================================
# SCRIPT DE PRE-INSTALACIÓN - ARCH LINUX AUTOMATIZADO
# =====================================================================
set -e

# =====================================================================
# PANEL DE CONFIGURACIÓN PRINCIPAL (Modifica esto según tus necesidades)
# =====================================================================
HOSTNAME="ArchLinux"
PASS_ROOT="ggmitre"
NUEVO_USUARIO="demian"
PASS_USUARIO="terrible"

# Configuración Regional
ZONA_HORARIA="America/Lima"
TECLADO="dvorak-programmer"
IDIOMA="es_PE.UTF-8"
LOCALE_LINE="es_PE.UTF-8 UTF-8"

# Selección de Software
PAQUETES_SISTEMA="base linux linux-firmware"
PAQUETES_HERRAMIENTAS="intel-ucode xorg-server xorg-xinit mesa sudo i3-wm ttf-dejavu gnu-free-fonts alacritty feh vim iwd firefox pipewire pipewire-alsa pipewire-pulse wireplumber git"
# =====================================================================

echo "=== 1. DETECTANDO DISCO PRINCIPAL ==="
# Filtra dispositivos físicos y toma el primero disponible
DISK_DETECTADO=$(lsblk -dn -o NAME,TYPE,SIZE | awk '$2=="disk" {print "/dev/"$1; exit}')

if [ -z "$DISK_DETECTADO" ]; then
    echo "Error: No se pudo detectar ningún disco duro disponible."
    exit 1
fi

echo "Se ha detectado el siguiente disco para la instalación: $DISK_DETECTADO"
read -p "¿Estás seguro de que deseas formatear $DISK_DETECTADO? Esto borrará TODO. (s/N): " CONFIRMACION

if [[ ! "$CONFIRMACION" =~ ^[Ss]$ ]]; then
    echo "Instalación cancelada por el usuario."
    exit 0
fi

DISK="$DISK_DETECTADO"

echo "=== 2. SINCRONIZANDO HORA ==="
timedatectl set-ntp true

echo "=== 3. PARTICIONADO AUTOMÁTICO (sfdisk) ==="
# Limpieza de tablas previas
sgdisk --zap-all "$DISK"

# Esquema solicitado: 1G EFI, 4G Swap, 40G Root, Restante Home
sfdisk --label gpt "$DISK" <<EOF
size=1G,  type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="EFI System"
size=4G,  type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F, name="Linux swap"
size=45G, type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="Linux Root"
type=0FC63DAF-8483-4772-8E79-3D69D8477DE4, name="Linux Home"
EOF

echo "=== 4. FORMATEANDO PARTICIONES ==="
# Manejo dinámico de nombres de partición si el disco es NVMe (agrega 'p')
if [[ "$DISK" == *"nvme"* ]]; then
    P="p"
else
    P=""
fi

mkfs.vfat -F32 "${DISK}${P}1"
mkswap "${DISK}${P}2"
swapon "${DISK}${P}2"
mkfs.ext4 -F "${DISK}${P}3"
mkfs.ext4 -F "${DISK}${P}4"

echo "=== 5. MONTANDO UNIDADES EN ORDEN CORRECTO ==="
# Primero la raíz raíz (/) para no pisar montajes posteriores
mount "${DISK}${P}3" /mnt

# Estructura interna
mkdir -p /mnt/boot/efi
mkdir -p /mnt/home

# Montajes secundarios
mount "${DISK}${P}1" /mnt/boot/efi
mount "${DISK}${P}4" /mnt/home

echo "=== 6. INSTALANDO SOFTWARE BASE (PACSTRAP) ==="
pacstrap /mnt $PAQUETES_SISTEMA $PAQUETES_HERRAMIENTAS

echo "=== 7. GENERANDO TABLA FSTAB ==="
genfstab -U /mnt >> /mnt/etc/fstab

echo "=== 8. ENVIANDO CONTROL AL CHROOT ==="
if [ ! -f "chroot.sh" ]; then
    echo "Error crítico: No se encuentra el archivo chroot.sh en el directorio actual."
    exit 1
fi

cp ../dotfiles /mnt -r

# Pasar todas las variables posicionales al script secundario
arch-chroot /mnt bash /dotfiles/chroot.sh \
  "$DISK" \
  "$NUEVO_USUARIO" \
  "$PASS_USUARIO" \
  "$PASS_ROOT" \
  "$ZONA_HORARIA" \
  "$TECLADO" \
  "$IDIOMA" \
  "$LOCALE_LINE" \
  "$HOSTNAME"

echo "====================================================================="
echo "¡FASE 1 COMPLETADA CON ÉXITO!"
echo "Puedes desmontar con 'umount -R /mnt' y reiniciar con 'reboot'."
echo "====================================================================="

echo "nameserver 1.1.1.1" >> /mnt/etc/resolv.conf
echo "nameserver 8.8.8.8" >> /mnt/etc/resolv.conf
rm /mnt/dotfiles -rf

reboot
