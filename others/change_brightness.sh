#!/usr/bin/env bash
#
################################################
#
# DESCRICAO: 	Altera brilho da tela via dialog
# AUTOR:		lenonr
#
################################################
#
# DATA_CRIACAO: 06/09/19
# ULT_MODIFICA: 09/09/19
# VERSAO:		0.16
#
################################################
#
tx=100
#
f_verifica()
{
	[[ $? == "1" ]] && exit 1
}

up_brightness()
{
	old_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

	echo $(( $old_brightness + $tx )) > /sys/class/backlight/intel_backlight/brightness
}

down_brightness()
{
	old_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

	echo $(( $old_brightness - $tx )) > /sys/class/backlight/intel_backlight/brightness
}

menu_brightness()
{
	change=$(dialog \
            --stdout --ok-label "Change" --cancel-label "Exit" \
            --menu "Change brightness your monitor:" 0 0 0 \
            "-" "-" \
            "+" "+" ) ;

    f_verifica
}

change_brightness()
{
	menu_brightness

	if [[ $change = "+" ]]; then
		up_brightness
	elif [[ $change = "-" ]]; then
		down_brightness
	fi
}

main()
{
	# verifica se root
	[[ `id -u` -ne 0 ]] && \
    	echo "## PRECISA DE ROOT ##" && exit 1    	

	while [[ TRUE ]]; do
		change_brightness
	done	
}

main