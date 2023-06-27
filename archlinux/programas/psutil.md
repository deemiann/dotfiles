# Psutil

## Intalacion

```console
$ sudo pacman -S wget
$ wget https://bootstrap.pypa.io/get-pip.py -O - | python3
$ python3 -m pip install psutil
```

## Widget modificacion

```console
$ sudo vim /usr/lib/python3.10/site-packages/libqtile/widget/memory.py
```

```vim
    def poll(self):
        mem = psutil.virtual_memory()
        swap = psutil.swap_memory()
        memU = mem.used / self.calc_mem
        totalU = mem.total / self.calc_mem
        val["MemPercentU"] = memU / totalU * 100
```

---

```console
$ sudo vim /usr/lib/python3.10/site-packages/libqtile/widget/backlight.py
```

```vim
        if direction is ChangeDirection.DOWN:
            new = max(now - step, 5)
```
