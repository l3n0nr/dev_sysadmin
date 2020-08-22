#!/usr/bin/env bash
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por l3n0nr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [28/03/18]      #
# # ultima ediçao realizada:      [21/08/20]      #
# # versao do script :			  [	 0.28  ] 	  #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#
## VARIAVEIS
servidor="google.com"
tempo=60
contador=0
tempo_desliga=30

check_internet()
{
	data=$(date +%k:%M:%S)
	ping -q -c4 $servidor &> /dev/null 

	if [ $? == "0" ]; then	
		mensagem="Internet funcionando!"
		echo $mensagem $data
		notify-send "$mensagem"
		contador=0
		exit 0
	else				
		mensagem="- Sem conexao!"	
		echo $mensagem $data
		let contador++	
	fi		
}

while_internet()
{
	while true; do			
		if [[ $contador == $tempo_desliga ]]; then
			# desliga apos N minutos
			xfce4-session-logout --halt
		fi

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