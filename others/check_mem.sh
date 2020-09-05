#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  15/01/19
# VERSAO: 		0.85
# AUTOR:		lenonr
###########################
#
export DISPLAY=":0.0"

check()
{
	taxa_warn="25"

	mem_total="$(($(free -t | awk '/Total:/ {print $2}') / 1024))"
	mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"
	mem_tax="$((($mem_liv * 100) / $mem_total))"

	if [[ $taxa_warn -ge $mem_tax ]]; then
		notify-send -t 10000 "Ei, apenas $mem_tax% de memoria livre!"
	else
		echo ""
	fi		
}

main()
{
	clear

	check
}

main