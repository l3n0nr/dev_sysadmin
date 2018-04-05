#!/bin/zsh
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [04/04/18]      #
# # ultima ediçao realizada:      [05/04/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
# DESCRICAO
# Chamando script's para rotina automatizadas
#
#variaveis
tempo=3600s					# 1 hora				
tempo_DATE="3600 seconds"
							# 1 min		 = 60 seconds;
							# 60 min 	 = 3600 seconds;

# mostrando data de execucao inicial
date > /tmp/main.txt

# atualizando update_zshrc 				-				apenas uma vez(inicializaçao do script)
printf "\nExecutando arquivo update_zshrc.sh" >> /tmp/main.txt
./update_zshrc.sh 

while true; do
	printf "\nLoop executado em: " >> /tmp/main.txt
	date >> /tmp/main.txt

	# verificando internet
	printf "\nExecutando arquivo internet.sh" >> /tmp/main.txt
	./internet.sh

	# atualizando repositorios github
	printf "\nExecutando arquivo repo.sh" >> /tmp/main.txt
	./repo.sh	

	echo "\n\nProxima verificação em:" >> /tmp/main.txt
	date -d "$tempo_DATE" >> /tmp/main.txt

	sleep $tempo	
done