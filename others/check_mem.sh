#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  13/01/19
# VERSAO: 		0.52
# AUTOR:		lenonr
###########################
#
export DISPLAY=":0.0"

# variaveis
mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"
mem_war="2048"
mem_lim="1024"

verifica()
{
	if [[ "$mem_liv" -le "$mem_lim" ]]; then
		notify-send -t 10000 "Computador lento, apenas $mem_liv MB livres!"
	elif [[ "$mem_war" -ge "$mem_liv" ]]; then
		notify-send -t 10000 "Computador começando a ficar lento, apenas $mem_liv MB livres!"
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