#!/usr/bin/env bash
#
###################
#
# DESCRICAO: Fecha janela de acordo com o PID
# DATA_CRIA: 04/09/19
# ULT_MODIF: 03/10/20
# VERSAO:	 0.20
#
# REFERENCE:
# 	<https://askubuntu.com/questions/553203/how-to-close-only-one-window-of-an-application>
#
####################
#
close_window()
{
	## descobre nome da janela ativa
	window_name=$(xdotool getactivewindow getwindowname)

	## se estiver na area de trabalho volta para a janela anterior
	## senao fecha a atual.
	if [[ $window_name != "Área de trabalho" ]] || [[ $window_name == "Desktop" ]]; then		
		wmctrl -c :ACTIVE:		
	fi
}

show_window()
{
	## descobre nome da janela ativa
	window_name=$(xdotool getactivewindow getwindowname)

	if [[ $window_name == "Área de trabalho" ]] || [[ $window_name == "Desktop" ]]; then
		wmctrl -k off		
	else
		wmctrl -k on
	fi
}

main()
{
	if [[ $1 == "close" ]]; then
		close_window
	else
		show_window
	fi

}

main $1