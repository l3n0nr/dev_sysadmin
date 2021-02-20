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
# # ultima ediçao realizada:      [20/02/21]      #
# # versao do script :			  [	 0.30  ] 	  #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#
## VARIAVEIS
servidor="google.com"
tempo=60	
contador=0
limite=4
mensagem_on="- ON!"
mensagem_off="- OFF!"

check_internet()
{
	data=$(date +%k:%M:%S)
	ping -q -c$limite $servidor &> /dev/null 

	if [ $? == "0" ]; then	
		echo $mensagem_on $data
		contador=0
	else				
		echo $mensagem_off $data
		let contador++	
	fi			
}

while_internet()
{	
	for (( i = 0; i < $tempo_desliga; i++ )); do
		if [[ $contador == $limite ]]; then
			echo "Desligando computador"
			xfce4-session-logout --halt
			exit 0
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

	echo "# Tentando até" $tempo_desliga "minuto(s)..."

	while_internet $1
}

main $1