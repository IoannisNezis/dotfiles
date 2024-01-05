# This file gets sourced if nu is opend as login shell

#============================
# Load nu-spells
source docker.nu
source git.nu

#============================
use todo

#===========================
# aliases
alias dc = docker compose
alias ll = ls -al
alias vim = nvim

alias dotfiles = cd $env.DOTFILES
alias spells = cd $env.SPELLS

alias cat = bat

alias tl = tmux list-sessions
alias ta = tmux attach -t
alias ts = tmux new-session -s

alias sys-update = sudo pacman -Syu --noconfirm
