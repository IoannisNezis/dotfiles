#! /bin/nu
slurp | str trim | grim -g $in
let name = (ls ~/Pictures/ | sort-by modified | reverse |first | get name)
notify-send $"Screenshot saved\n($name)"
