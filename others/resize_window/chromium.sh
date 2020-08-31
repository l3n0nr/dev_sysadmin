#!/usr/bin/env zsh
#
## REFERENCE
#	https://www.sitepoint.com/community/t/keeping-chrome-window-position-and-size-constant/198439
#
## chama arquivo externo
source resolution.sh
#
chromium()
{
	## chama funcao externa
	resolution

	## call chromium and open in background
	/usr/bin/chromium %U --password-store=basic --window-position=70,70 --window-size=$calc_width,$calc_height
}

main()
{
	chromium
}

main