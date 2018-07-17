#!/usr/bin/env bash

# Descricao: Chama script de backup caso caminho exista, via alias.

verificahd()
{	
    local_hdd='/media/lenonr/BACKUP/Arquivos/Filmes'

  	clear 

  	# verificando se diretorio existe 
  	if [ -e "$local_hdd" ]; then 
      /home/lenonr/Github/dev_sysadmin/others/verifica_midia.sh
  	else
		echo "Conecte o HDD ao computador!"
	fi
}

main()
{
	verificahd
}

## chamando funcao principal
main