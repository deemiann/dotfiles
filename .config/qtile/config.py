# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

bg0_h = "#1d2021"
fg = "#ebdbb2"
gray = "#a89984"
aqua = "#8ec07c"
orange = "#fe8019"
purple = "#d3869b"
blue = "#83a598"
yellow = "#fabd2f"
green = "#b8bb26"
red = "#fb4934"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "g", lazy.layout.grow()),
    Key([mod], "s", lazy.layout.shrink()),
    Key([mod], "x", lazy.layout.maximize()),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    #Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Return", lazy.spawn("alacritty"), desc="Launch terminal"),
    Key([mod], "m", lazy.spawn("rofi -show drun"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], 'comma', lazy.next_screen(), desc='Next monitor'),
]

icons = ["", "", "爵", "", ""]
groups = [Group(i) for i in icons]
letters = ["a", "o", "e", "u", "i"]

for letter, icon in zip(letters, groups):
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                letter,
                lazy.group[icon.name].toscreen(),
                desc="Switch to group {}".format(icon.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                letter,
                lazy.window.togroup(icon.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(icon.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(
        border_focus = "#E41749",
        border_normal = bg0_h,
        border_width = 3,
    ),
    layout.MonadWide(
        border_focus = "#E41749",
        border_normal = bg0_h,
        border_width = 3,
    ),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Max(),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font Mono",
    fontsize=14,
    padding=0,
)
extension_defaults = widget_defaults.copy()

groupAqua = "#7cd7c2"
groupPurple = "#4e379e"
groupPurpleOther = "#7671c1"

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    scale = 0.6,
                    padding = 0,
                ),
                widget.GroupBox(
                    active = groupAqua,
                    inactive = "#282828",
                    highlight_method = "block",
                    this_current_screen_border = groupPurple,
                    this_screen_border = groupPurpleOther,
                    other_screen_border = "#504945",
                    other_current_screen_border = "#504945",
                    padding_x = 5,
                    margin_y = 3,
                    margin = 0,
                    fontsize=30,
                    background=bg0_h,
                ),
                widget.Spacer(length=20),
                widget.WindowName(
                    background="#1d2021"
                ),
                widget.Spacer(length=20),
                widget.TextBox(
                    fmt="",
                    foreground=green,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=green,
                    fontsize=24,
                ),
                widget.CheckUpdates(
                    distro = "Arch_checkupdates",
                    no_update_string = "0",
                    colour_no_updates = bg0_h,
                    colour_have_updates = "#cc241d",
                    initial_text = "0",
                    display_format = "{updates}",
                    background = green,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=green,
                    foreground=gray,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=gray,
                    fontsize=24,
                ),
                widget.Net(
                    interface = "eno1",
                    format = "{down}",
                    use_bits = True,
                    background = gray,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=gray,
                    fontsize=15,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=gray,
                    fontsize=15,
                ),
                widget.Net(
                    interface = "eno1",
                    format = "{up}",
                    use_bits = True,
                    background = gray,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=gray,
                    foreground=orange,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=orange,
                    fontsize=20,
                ),
                widget.DF(
                    visible_on_warn = False,
                    format = "{r:>2.0f}%",
                    warn_color = "#cc241d",
                    background = orange,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=orange,
                    foreground=aqua,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="ﳚ",
                    foreground=bg0_h,
                    background=aqua,
                    fontsize=20,
                ),
                widget.Memory(
                    format="{MemPercentU:>2.0f}%",
                    background = aqua,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=aqua,
                    foreground=purple,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=purple,
                    fontsize=26,
                ),
                widget.CPU(
                    format="{load_percent:>2.0f}%",
                    background = purple,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=purple,
                    foreground=blue,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=blue,
                    fontsize=16,
                ),
                widget.ThermalZone(
                    fmt="{}",
                    fgcolor_normal = bg0_h,
                    high=60,
                    #fgcolor_high = orange,
                    fgcolor_high = "#d65d0e",
                    crit=70,
                    #fgcolor_crit = red,
                    fgcolor_crit = "#cc241d",
                    format_crit = "{temp}°C",
                    background = blue,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=blue,
                    foreground=yellow,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=yellow,
                    fontsize=26,
                ),
                widget.Backlight(
                    fmt="{}",
                    backlight_name="intel_backlight",
                    step = 5,
                    change_command= "light -S {0}",
                    background = yellow,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=yellow,
                    foreground=red,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="ﰝ",
                    foreground=bg0_h,
                    background=red,
                    fontsize=26,
                ),
                widget.PulseVolume(
                    fmt="{:>4}",
                    background = red,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=red,
                    foreground=green,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=green,
                    fontsize=22,
                ),
                widget.Clock(
                    format="%a %d-%m-%y",
                    background = green,
                    foreground = bg0_h,
                    padding = 2,
                ),
                widget.TextBox(
                    fmt="",
                    background=green,
                    foreground=gray,
                    fontsize=22,
                ),
                widget.TextBox(
                    fmt="",
                    foreground=bg0_h,
                    background=gray,
                    fontsize=26,
                ),
                widget.Clock(
                    format="%H:%M:%S",
                    background = gray,
                    foreground = bg0_h,
                    padding = 2,
                ),
            ],
            24,
            background = bg0_h,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(
                    scale = 0.6,
                    padding = 0,
                ),
                widget.GroupBox(
                    active = groupAqua,
                    inactive = "#282828",
                    highlight_method = "block",
                    this_current_screen_border = groupPurple,
                    this_screen_border = groupPurpleOther,
                    other_screen_border = "#3c3836",
                    other_current_screen_border = "#3c3836",
                    padding_x = 5,
                    margin_y = 3,
                    margin = 0,
                    fontsize=30,
                    background=bg0_h,
                ),
                widget.Spacer(length=20),
                widget.WindowName(),
                widget.Spacer(length=20),
            ],
            24,
            background = bg0_h,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

import os
import subprocess
from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])
