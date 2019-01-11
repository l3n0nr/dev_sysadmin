#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  11/01/19
# VERSAO: 		0.40
# AUTOR:		lenonr
###########################
#
# variaveis
mem_total="$(($(free -t | awk '/Total:/ {print $2}') / 1024))"
mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"

# taxa="30"

# mem_taxa="$(echo $mem_total/$mem_liv | bc)"

mem_lim="1000"
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