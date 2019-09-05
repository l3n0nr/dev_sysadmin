#!/usr/bin/env bash
#
###################
#
# DESCRICAO: Fecha janela de acordo com o PID
# DATA_CRIA: 04/09/19
# ULT_MODIF: 05/09/19
# VERSAO:	 0.15
#
# REFERENCE:
# 	<https://askubuntu.com/questions/553203/how-to-close-only-one-window-of-an-application>
#
####################
#
get_pid()
{
	window_name=$(xdotool getactivewindow getwindowname)

	# se estiver na area de trabalho nao executa 
	if [[ $window_name != "Área de trabalho" ]]; then
		wmctrl -c :ACTIVE:		
	fi
}

main()
{
	get_pid
}

main