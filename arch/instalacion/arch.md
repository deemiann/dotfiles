# Instalacion de Arch Linux

## Cargar teclado
```console
$ loadkeys dvorak-programmer
```
## Verificar si hay internet
```console
$ ping google.com
```

## Sincronizar hora
```console
$ timedatectl set-ntp true
$ timedatectl status
```

## Ver particiones 
```console
$ lsblk
$ fdisk -l
```

## Particiones
### Verificar si es EFI
```console
$ ls /sys/firmware/efi/efivars
$ foo
```
### Crear particiones
```console
$ cfdisk
```

#### Seleccionar gpt
1. **dev/sda1**
    * **size:** 512M
    * **type:** EFI System
    * **write**
2. **dev/sda2**
    * **size:** 20G
    * **type:** Linux
    * **write**
3. **dev/sda3:** 
    * **size:** 76.4G (variable)
    * **type:** Linux
    * **write**
4. **dev/sda4:**
    * **size:** 4G
    * **type:** Linux swap
    * **write**

## Systema de Archivos
```console
$ mkfs.vfat -F32 /dev/sda1
$ mkfs.ext4 /dev/sda2
$ mkfs.ext4 /dev/sda3
$ mkswap /dev/sda4
$ swapon /dev/sda4    # encender swap
```

## Montar particiones
```console
$ mount /dev/sda2 /mnt
$ mkdir -p /mnt/boot/efi    # crear efi
$ mount /dev/sda1 /mnt/boot/efi 
$ mkdir /mnt/home   # crear home
$ mount /dev/sda3 /mnt/home
```

## Instalar paquetes en /mnt
```console
$ pacstrap /mnt base base-devel linux linux-firmware vim \
      efibootmgr grub networkmanager
```
---

```console
$ genfstab -U /mnt >> /mnt/etc/fstab
```

```console
$ arch-chroot /mnt
```

```console
$ ln -sf /usr/share/zoneinfo/America/Lima /etc/localtime
```

```console
$ hwclock --systohc
```

```console
$ echo "ArchLinux" > /etc/hostname
```
---
```console
$ vim /etc/hosts
```
```vim
127.0.0.1        localhost
::1              localhost
127.0.1.1        ArchLinux.localdomain ArchLinux
~
```
---
```console
$ echo "KEYMAP=dvorak-programmer" > /etc/vconsole.conf
$ echo "LANG=es_PE.UTF-8" > /etc/locale.conf
```
---
```console
$ vim /etc/locale.gen
```
desmarcar **es_PE.UTF-8 UTF-8**
```console
#es_PA ISO-8859-1  
es_PE.UTF-8 UTF-8  
#es_PE ISO-8859-1  
```
```console
$ locale-gen
```
---
## Contrasena root
```console
$ passwd
```
## Agregar usuario
```console
$ useradd -m demian
$ passwd demian
```
## Agregar a Grupos
```console
$ usermod -aG wheel,audio,video,optical,storage demian
```
---
## Sudo
```console
$ visudo
```
```vim
## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL:ALL) ALL
```
---
## Networkmanager
```console
$ systemctl enable NetworkManager.service
```
## Grub
```console
$ grub-install --efi-directory=/boot/efi --bootloader \
      -id='Arch Linux' --target=x86_64-efi
$ grub-mkconfig -o /boot/grub/grub.cfg
```
---
## Ultimo
```console
$ mkinitcpio -P
$ exit
$ shutdown now
```
desconectar usb antes de prender
