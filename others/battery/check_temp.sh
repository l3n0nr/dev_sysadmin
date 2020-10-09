#!/usr/bin/env bash
#
######################################################################
# DESCRICAO
#		Extrai temperatura do processador 
#		e desliga o computador, caso necessario.
######################################################################
#
# DAT_CRIAC	:	08/10/20
# LAST_MOD	:	09/10/20
# VERSAO	:	0.20
# AUTOR 	:	l3n0nr
######################################################################
#
# capturando temperatura
temp=$(tlp-stat -t | grep CPU | awk {'print $4'})

# valores de referencia
margem_lim="95"
margem="85"

# mensagens para o usuario
mensagem="CPU à $temp C, é melhor desligar."
mensagem_limite="Computador desligando AGORA!"

# saida de log
log_temp="/tmp/log_temp"

# data personalizada
tempo_verifica=$(date)

check_files()
{
	if [[ ! -e $log_temp ]]; then
		touch $log_temp
		echo "" > $log_temp
	fi
}

temperature()
{	
	if [[ $temp > $margem ]]; then
		notify-send -t 10000 "$mensagem"
	fi

	if [[ $temp > $margem_lim ]]; then
		notify-send -t 10000 "$mensagem_limite"
	fi		
	
	echo "" $tempo_verifica >> $log_temp
}

main()
{
	clear

	check_files
	temperature
}

main