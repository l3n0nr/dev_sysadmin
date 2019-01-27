#!/usr/bin/env bash
#
##########################################
# REFERENCIA 
#		https://youtu.be/8Lam1iVZIGA
#
# DESCRICAO
#		Toca web radio no terminal
##########################################
#
# DATA_CRIACAO: 26/01/19
# ULT_MODIFIC:  27/01/19
#
verifica_internet()
{
	ping_server="www.google.com"
	
  	ping -c1 $ping_server >> /dev/null
  	[[ ! $? -eq 0 ]] && echo "SEM CONEXAO!" && exit 1
}

radio()
{
	declare -A STREAM
	
	source radio

	PS3=$'\nSelecione uma radio:'
	select radio in "${!STREAM[@]}"; do
		title="${radio}"
		ip="${STREAM[$radio]}"
		echo -e "\033[31;1mVoce esta ouvindo: $title (Ctrl+C para sair)\033[m"
		ffplay -nodisp $ip &> /dev/null
	done
}

main()
{
	clear
	# verifica_internet
	radio
}

main