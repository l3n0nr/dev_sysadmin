#!/usr/bin/env bash
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [28/03/18]      #
# # ultima ediçao realizada:      [02/05/19]      #
# # versao do script :			  [	 0.25  ] 	  #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#
## VARIAVEIS
servidor="google.com"
tempo=60

check_internet()
{
	data=$(date +%k:%M:%S)
	ping -q -c4 $servidor &> /dev/null 

	if [ $? == "0" ]; then	
		mensagem="Internet funcionando!"
		echo $mensagem $data
		notify-send "$mensagem"
		exit 0
	else				
		mensagem="- Sem conexao!"		
		echo $mensagem $data
	fi		
}

while_internet()
{
	while true; do			
		check_internet
		sleep $tempo
	done
}

main()
{
	clear
	while_internet
}

main