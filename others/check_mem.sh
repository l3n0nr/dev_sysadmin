#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  12/01/19
# VERSAO: 		0.46
# AUTOR:		lenonr
###########################
#
export DISPLAY=":0.0"

# variaveis
mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"
mem_war="1500"
mem_lim="1000"

verifica()
{
	if [[ "$mem_liv" -le "$mem_lim" ]]; then
		notify-send -t 10000 "Aparentemente esta lento, apenas $mem_liv MB livre!"
	elif [[ "$mem_war" -ge "$mem_liv" ]]; then
		notify-send -t 10000 "Memoria em atençao $mem_liv MB!"
	else
		# notify-send -t 10000 "Memoria normal!"
		echo ""
	fi
}

main()
{
	verifica
}

main