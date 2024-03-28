sddm is a display manager that is compatible with hyprland.
For more information check [this](https://wiki.archlinux.org/title/SDDM) page.

# Theme

I used the sugar-candy theme, this can be found [here](https://github.com/Kangie/sddm-sugar-candy).
the themes are stored here `/usr/share/sddm/themes/`

# Installation

1. Create a symlink in `/etc/sddm.conf.d/` to the local conf file.
2. Create a symlink int `/usr/share/sddm/themes` to the local theme.

Here is a a command to do both:
```bash
just install
```

# Update changes

When the theme is updated in these docfiles it needs to be copied again.
To save you some valuable seconds, here is a command to do that:
```bash
just update
```
