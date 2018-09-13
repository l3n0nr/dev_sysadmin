#!/usr/bin/env bash

# Descricao: Chama script de backup caso caminho exista, via alias.

hdd="/media/lenonr/BACKUP"
local_hdd='$hdd/Arquivos/Filmes'

verificahd()
{	
  	# verificando se diretorio existe 
  	if [ -e "$local_hdd" ]; then 
      /home/lenonr/Github/dev_sysadmin/others/verifica_midia.sh
  	else
		echo "Conecte o $hdd ao computador!"
	fi
}

main()
{
	clear
	verificahd
}

## chamando funcao principal
main