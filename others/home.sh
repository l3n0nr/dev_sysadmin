#!/usr/bin/env bash

# Descricao: Mostra pasta do usuario com formatacao, via alias.

home()
{	
  	echo "########## LISTA DE ARQUIVOS ##########" 
  	cd $HOME
  	ls
  	echo "######################################"  	
}

main()
{
	home
}

## chamando funcao principal
main