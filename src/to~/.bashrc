#
# ~/.bashrc
#

# Si estamos en la primera terminal de texto (TTY1), arranca X automáticamente
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec startx >/dev/null 2>&1
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(dircolors -b ~/.dircolors)"
#PS1='\e[1;91m\]┌┤ \[\e[1;96m\]\u\[\e[1;97m\]@\[\e[1;95m\]\h\[\e[1;97m\]:\[\e[1;94m\]\w\e[1;90m\]\n\[\e[1;91m\]└$\[\e[0;97m\] '
PS1='\e[1;96m\]┌─┤ \[\e[1;94m\]\w\n\[\e[1;96m\]└─$\[\e[0;97m\] '

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -la'
alias grep='grep --color=auto'
alias cl='clear'
alias d='date'
alias ssn='sudo shutdown now'
alias srr='sudo reboot'
alias ram='free | awk '\''/Mem:/ {printf "RAM: %.0f%%\n", $3/$2 * 100}'\'''

ramwatch(){
    while true; do
        printf "\r"
        free | awk '/Mem:/ {printf "RAM: %.0f%%", $3/$2 * 100}'
        sleep 1
    done
}

cpu() {
    read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
    total1=$((user+nice+system+idle+iowait+irq+softirq+steal))
    idle1=$idle

    sleep 1

    read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
    total2=$((user+nice+system+idle+iowait+irq+softirq+steal))
    idle2=$idle

    total=$((total2-total1))
    idle=$((idle2-idle1))

    awk -v t="$total" -v i="$idle" 'BEGIN {
        if (t > 0)
            printf "CPU: %2.0f", (1 - i/t)*100
        else
            print "CPU: 0"
    }'
    printf "%%\n"
}

cpuwatch() {
    while true; do
        printf "\r"
        read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
        total1=$((user+nice+system+idle+iowait+irq+softirq+steal))
        idle1=$idle

        sleep 1

        read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
        total2=$((user+nice+system+idle+iowait+irq+softirq+steal))
        idle2=$idle

        total=$((total2-total1))
        idle=$((idle2-idle1))

        awk -v t="$total" -v i="$idle" 'BEGIN {
            if (t > 0)
                printf "CPU: %2.0f", (1 - i/t)*100
            else
                print "CPU: 0"
        }'
        printf "%%"
    done
}
