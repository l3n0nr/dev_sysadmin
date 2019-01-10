#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
##########################
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  09/01/19
# AUTOR:		lenonr
#
# variaveis
mem_liv=$(($(free -t | awk '/Total:/ {print $4}') / 1024))
mem_lim="500"
#
verifica()
{
	# echo $mem_liv "MB"
	# echo $mem_lim "MB"

	if [[ $mem_liv > $mem_lim ]]; then
		notify-send "Aparentemente esta lento, $USER?"
	else
		notify-send "Super-rapidao ne, $USER!"
	fi
}

main()
{
	verifica
}

main