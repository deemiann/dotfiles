# Entorno grafico

## Instalar

```console
$ sudo pacmam -S xf86-video-intel intel-ucode xorg-server \
      xorg-xinit mesa mesa-demos lightdm lightdm-gtk-greeter \
      qtile pulseaudio pulseaudi-alsa pamixer
```

---

## Agregar teclado

```console
$ cp ~/dotfiles/arch/entorno-grafico/20-keyboard.conf /etc/X11/xorg.conf.d/
```

---

## Agregrar greeter

```console
$ sudo vim /etc/lightdm/lightdm.conf
```

modificar session

```vim
#xdmcp-key=
greeter-session=lightdm-gtk-greeter
#greeter-hide-users=false
```

---

## Permitir lightdm

```console
$ sudo systemctl enable lightdm.service
```
