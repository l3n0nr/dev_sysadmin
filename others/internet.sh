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
# # ultima ediçao realizada:      [20/01/21]      #
# # versao do script :			  [	 0.29  ] 	  #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#
## VARIAVEIS
servidor="google.com"
tempo=60
contador=0

check_internet()
{
	data=$(date +%k:%M:%S)
	ping -q -c4 $servidor &> /dev/null 

	if [ $? == "0" ]; then	
		mensagem="- ON!"
		echo $mensagem $data
		notify-send "INTERNET FUNCIONANDO"
		contador=0
		exit 0
	else				
		mensagem="- OFF!"	
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
	
	# se usuario nao passar parametro, entao aguarda 15 minutos para desligar maquina sem conexao
	if [[ $1 == "" ]]; then
		tempo_desliga=15
	else
		tempo_desliga=$1
	fi	

	echo "# Tentando até" $tempo_desliga "minuto(s), antes de desligar."

	while_internet $1
}

main $1