#! /bin/nu

def get_kbbrightness [] {
	return (brightnessctl -d *::kbd_backlight get)
}

def rotate [] {
	if (get_kbbrightness) == "0" {
		brightnessctl -d *::kbd_backlight set 1
		notify-send $"Keyboard-brightness at 50%"
	} else if (get_kbbrightness) == "1" {
		brightnessctl -d *::kbd_backlight set 2
		notify-send $"Keyboard-brightness at 100%"
	} else {
		brightnessctl -d *::kbd_backlight set 0
		notify-send $"Keyboard-brightness at 0%"
	}
}

rotate
