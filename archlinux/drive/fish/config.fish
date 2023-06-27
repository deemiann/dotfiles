set fish_greeting ""

set -gx TERM xterm-256color

alias vim "nvim"
alias ls "exa --icons -g"
alias ll "ls -l"
alias la "ll -a"
alias lld "ll --group-directories-first"
alias lad "la --group-directories-first"
alias cat "bat --theme gruvbox-dark"
alias ide "~/.ide"

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
