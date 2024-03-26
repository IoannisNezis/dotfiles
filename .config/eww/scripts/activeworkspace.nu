#! /bin/nu
hyprctl activeworkspace | lines | first | split row " " | get 2 
