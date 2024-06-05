#!/bin/nu
let workspace = (hyprctl activeworkspace -j | from json | get id)
print $"detected workspace: ($workspace)"

match $workspace {
  1 => {
    thunderbird
  },
  2 => {
    pueue add --immediate alacritty
  }
  3 => {
    pueue add --immediate firefox
  }
  4 => {
    pueue add --immediate alacritty
  }
  5 => {
    pueue add --immediate alacritty
  }
  6 => {
    pueue add --immediate okular
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

