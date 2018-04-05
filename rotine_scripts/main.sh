#!/bin/bash
# chamando script's para rotina

# tempo_internet="300 seconds"
# tempo_repo="14400 seconds"
# tempo_update_zshrc="seconds"

date >> /tmp/main.txt

tempo=3600s				# 1 hora
						# 1 min		 = 60 seconds;
						# 60 min 	 = 3600 seconds;

while true; do
	# verificando internet
	./internet.sh

	# atualizando repositorios github
	./repo.sh

	# atualizando zshrc
	./update_zshrc.sh 

	sleep $tempo
done