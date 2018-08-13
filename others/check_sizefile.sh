#!/usr/bin/env bash

## DESCRICAO
# Verifica tamanho arquivos discos

## DATA
# Criacao: 13/08/18
# Ultim. Mod: 13/08/18

## VARIAVEIS
tamanho="15"

## FUNCOES
check_file()
{
	du -hx $1 | sort -h | tail -$tamanho
}

main()
{
	if [[ $1 == "" ]]; then
		clear
		printf "ERRO! Necessita de um local para verificar" 
	else
		clear
		check_file $1
	fi	
}

## CHAMANDO SCRIPT
main $1