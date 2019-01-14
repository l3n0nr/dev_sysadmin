#!/usr/bin/env bash
#
##########################
## DESCRICAO DO SCRIPT
#	Verifica memoria total e envia mensagem para usuario
#
# DATA_CRIACAO: 09/01/19
# ULT_MODIFIC:  14/01/19
# VERSAO: 		0.70
# AUTOR:		lenonr
###########################
#
export DISPLAY=":0.0"

verifica()
{
	# variaveis
	mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"
	mem_war="2048"
	mem_lim="1024"

	if [[ "$mem_liv" -le "$mem_lim" ]]; then
		notify-send -t 10000 "Computador lento, apenas $mem_liv MB livres!"
	elif [[ "$mem_war" -ge "$mem_liv" ]]; then
		notify-send -t 10000 "Computador começando a ficar lento, apenas $mem_liv MB livres!"
	else
		# notify-send -t 10000 "Memoria normal!"
		echo ""
	fi
}

check()
{
	taxa_warn="40"
	taxa_lim="25"

	mem_total="$(($(free -t | awk '/Total:/ {print $2}') / 1024))"
	mem_liv="$(($(free -t | awk '/Total:/ {print $4}') / 1024))"
	mem_tax="$((($mem_liv * 100) / $mem_total))"

	if [[ $mem_tax -le $taxa_warn ]]; then
		notify-send -t 10000 "Computador começando a ficar lento, apenas $mem_liv MB livres!"
	elif [[ $mem_tax -le $taxa_lim ]]; then
		notify-send -t 10000 "Computador lento, apenas $mem_liv MB livres!"
	else
		# notify-send -t 10000 "Normal! $mem_liv MB livres!"
		echo "Memoria disponivel:" $mem_tax "%"
	fi

}

main()
{
	# verifica
	check
}

main