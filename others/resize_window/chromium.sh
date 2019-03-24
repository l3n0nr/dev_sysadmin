#!/usr/bin/env zsh

chromium()
{
	taxa_width="90"
	taxa_height="80"

	width=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
	height=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)	

	calc_width=$((($width * $taxa_width) / 100))
	calc_height=$((($height * $taxa_height) / 100))

	## call chromium and open in background
	/usr/bin/chromium %U --password-store=basic --window-position=70,70 --window-size=$calc_width,$calc_height
}

main()
{
	chromium
}

main