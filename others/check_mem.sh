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
mem_liv=$(($(free -t | awk '/Mem:/ {print $6}') / 1024))
mem_lim="500"
#
verifica()
{
	if [[ "$mem_lim" -ge "$mem_liv" ]]; then
		notify-send "Aparentemente esta lento, apenas $mem_liv MB livre!"
	else
		notify-send "Normal, $mem_liv MB $USER!"
	fi
}

main()
{
	verifica
}

main