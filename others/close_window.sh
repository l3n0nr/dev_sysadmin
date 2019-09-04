#!/usr/bin/env bash
#
###################
#
# DESCRICAO: Fecha janela de acordo com o PID
# DATA_CRIA: 04/09/19
# ULT_MODIF: 04/09/19
# VERSAO:	 0.10
#
####################
#
get_pid()
{
	window_pid=$(xdotool getactivewindow getwindowpid)

	kill $window_pid
}

main()
{
	get_pid
}

main