#!/usr/bin/env bash
#
######################################################################
# DESCRICAO
#		Extrai temperatura do processador
######################################################################
#
# DAT_CRIAC	:	08/10/20
# LAST_MOD	:	08/10/20
# VERSAO	:	0.15
# AUTOR 	:	l3n0nr
######################################################################
#
temperature()
{
	temp=$(tlp-stat -t | grep CPU | awk {'print $4'})
	margem="85"

	if [[ $temp > $margem ]]; then
		notify-send "Computador quente, é melhor desliga-lo"
	fi		
}

main()
{
	temperature
}

main