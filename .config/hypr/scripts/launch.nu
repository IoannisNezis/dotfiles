#!/bin/nu
let workspace = (hyprctl activeworkspace -j | from json | get id)

match $workspace {
  1 => {
    pueue add --immediate alacritty
  },
  2 => {
    pueue add --immediate alacritty
  }
  3 => {
    pueue add --immediate firefox
  }
  4 => {
    pueue add --immediate thunderbird
  }
  5 => {
    pueue add --immediate obsidian
  }
  6 => {
    pueue add --immediate alacritty
  }
  7 => {
    pueue add --immediate alacritty
  }
  8 => {
    pueue add --immediate alacritty
  }
  9 => {
    pueue add --immediate spotify-launcher
  }
  10 => {
    pueue add --immediate element-desktop
  }
}

