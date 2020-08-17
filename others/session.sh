#!/usr/bin/env bash
#
################################################
# DESCRICAO		:  	Suspende/Hiberna/Desliga
# VERSAO		: 	0.20
# AUTOR			: 	l3n0nr
################################################
#
date_now=$(date +%X)
#
################################################
#
## general functions
check()
{
	if [[ $2 == "" ]]; then		
		time="1"
	else
		time=$2
	fi

	if [[ $1 == "" ]]; then
		echo "Please, call one option: $0 suspend/hibernate/halt"
	else
		action=$1
	fi	

	# convertendo tempo para minutos
	time_conv=$(($time*60))

	## executando alguma acao
	if [[ $action == "suspend" ]]; then
		echo "Suspendendo o sistema em $time_conv segundos..."
		sleep $time_conv
		xfce4-session-logout --suspend
	elif [[ $action == "hibernate" ]]; then
		echo "Hibernando o sistema em $time_conv segundos..."
		sleep $time_conv
		xfce4-session-logout --hibernate
	elif [[ $action == "halt" ]]; then
		echo "Desligando o sistema em $time_conv segundos..."
		sleep $time_conv
		xfce4-session-logout --halt
	fi
}

## main functions
main()
{
	# limpando tela
	clear

	# chamando funcao principal
	check $1 $2
}

main $1 $2