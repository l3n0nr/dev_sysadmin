#!/bin/bash
# 
# Descricao
# chamando script's para rotina automatizadas
#
#################
# variaveis script
tempo=3600s				# 1 hora
						# 1 min		 = 60 seconds;
						# 60 min 	 = 3600 seconds;

# iniciando arquivo
printf "\nArquivo iniciado em: " > /tmp/main.txt
date >> /tmp/main.txt

# Inicio das tarefas
#################################################################
# executação de arquivos basicos 

# atualizando zshrc
printf "\nExecutando arquivo update_zshrc.sh" >> /tmp/main.txt
./update_zshrc.sh 

# reiniciando dropbox
printf "\nExecutando arquivo dropbox.sh" >> /tmp/main.txt
./dropbox.sh

# loop de execucao
#################################################################
# arquivos importantes

while true; do
	printf "\nLoop executado em: " >> /tmp/main.txt
	date >> /tmp/main.txt

	# verificando internet
	printf "\nExecutando arquivo internet.sh" >> /tmp/main.txt
	./internet.sh

	# atualizando repositorios github
	printf "\nExecutando arquivo repo.sh" >> /tmp/main.txt
	./repo.sh	

	# tempo entre loop de execucao
	sleep $tempo
done