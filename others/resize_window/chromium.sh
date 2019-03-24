#!/usr/bin/env zsh

chromium()
{
	## call chromium and open in background
	/usr/bin/chromium %U --password-store=basic
}

resize()
{
	source resize_window.sh chromium
}

main()
{
	chromium &
	sleep 1 &&
	resize
}

main