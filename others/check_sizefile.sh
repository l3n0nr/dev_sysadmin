#!/usr/bin/env bash

## DESCRICAO
# Verifica tamanho arquivos discos

## DATA SCRIPT
# CRIACAO: 13/08/18
# ULT_MOD: 29/01/19

## FUNCOES
check_file()
{
	du -hx $1 | sort -h | tail -$tamanho
}

main()
{
	if [[ $1 == "" ]]; then
		clear
		printf "Necessita de um local para verificar\n" 
		printf "Exemplo: '$0 /home 10'\n"
	else
		if [[ $2 == "" ]]; then
			tamanho="10"
		else
			tamanho="$2"
		fi

		clear

		check_file $1 $2
	fi	
}

## CHAMANDO SCRIPT
main $1 $2