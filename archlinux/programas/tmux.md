# Tmux y fish

## instalacion

```console
$ sudo pacman -S tmux fish fisher exa
$ fisher install IlanCosman/tide@v5 jethrokuan/z
```

## enable fish

```console
$ sudo vim /etc/shells
```

```vim
/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/bin/fish
```

```console
$ chsh -s /bin/fish
```
