#!/bin/bash
# chamando script's para rotina automatizadas

# tempo_internet="300 seconds"
# tempo_repo="14400 seconds"
# tempo_update_zshrc="seconds"

tempo=3600s				# 1 hora
						# 1 min		 = 60 seconds;
						# 60 min 	 = 3600 seconds;

date > /tmp/main.txt

# atualizando zshrc
printf "\nExecutando arquivo update_zshrc.sh" >> /tmp/main.txt
./update_zshrc.sh 

# reiniciando dropbox
printf "\nExecutando arquivo dropbox.sh" >> /tmp/main.txt
./dropbox.sh

while true; do
	printf "\nLoop executado em: " >> /tmp/main.txt
	date >> /tmp/main.txt

	# verificando internet
	printf "\nExecutando arquivo internet.sh" >> /tmp/main.txt
	./internet.sh

	# atualizando repositorios github
	printf "\nExecutando arquivo repo.sh" >> /tmp/main.txt
	./repo.sh	

	sleep $tempo
done