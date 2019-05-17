#!/usr/bin/env bash
#
################################################
# DESCRICAO		:  	Suspende/Hiberna computador
# VERSAO		: 	0.16
# AUTOR			: 	lenonr
################################################
#
## VARIAVEIS GLOBAIS
# tempo em segundos
time="0"

# tipo de acao
action=""

# data agora
date_now=$(date +%X)
################################################
#
action_suspend()
{
	echo "Suspendendo o sistema em $time_conv segundos..."
	sleep $time_conv
	echo "...suspendendo AGORA! $date_now" && sleep 3

	# suspendo sistema
	xfce4-session-logout --suspend
}

action_hibernate()
{
	echo "Hibernando o sistema em $time_conv segundos..."
	sleep $time_conv
	echo "...hibernando AGORA!" && sleep 3

	# hibernando sistema
	xfce4-session-logout --hibernate
}

check()
{
	## verificando tempo
	if [[ $2 == "" ]]; then		
		time="3" 	# 3 minutos
	else
		time=$2
	fi

	# convertendo tempo para minutos
	time_conv=$(($time*60))

	## verificando acao
	if [[ $1 == "" ]]; then
		echo "Please, call one option: $0 suspend/hibernate"
	else
		action=$1
	fi	

	## executando alguma acao
	if [[ $action == "suspend" ]]; then
		action_suspend
	elif [[ $action == "hibernate" ]]; then
		action_hibernate	
	fi
}

main()
{
	# limpando tela
	clear

	# chamando funcao principal
	check $1 $2
}

main $1 $2