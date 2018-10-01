#!/usr/bin/env bash
#
# ULT_MOD: 01/10/18
# DESCRICAO
# Simula o aplicativo pomodoro para controle de tempo na execucao das tarefas

# variaveis do programa
mensagem_inicia="Iniciando o pomodoro com"
mensagem_finaliza="Acabou a sua sessao!"

pomodoro()
{
	tempo="$(($1*60))"

	echo $mensagem_inicia $tempo "segundos!"
	echo "Contando.."
	sleep $tempo

	echo $mensagem_finaliza 
	notify-send -t 10000 "GOSTOU?"
}

main()
{
	clear
	if [[ $1 == "" ]]; then
		echo "Por favor, passe como parametro um tempo em minutos"
		echo "Exemplo: $0 10"
	else				
		pomodoro $1
	fi
}

# chamando funcao principal
main $1