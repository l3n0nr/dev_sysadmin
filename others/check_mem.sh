#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  11/01/19
# AUTOR:		lenonr
###########################
#
# variaveis
mem_liv=$(($(free -t | awk '/Total:/ {print $4}') / 1024))
mem_lim="500"
#
verifica()
{
	if [[ $mem_liv > $mem_lim ]]; then
		notify-send "Aparentemente esta lento, $USER?"
	else
		notify-send "Normal, $USER!"
	fi
}

main()
{
	verifica
}

main