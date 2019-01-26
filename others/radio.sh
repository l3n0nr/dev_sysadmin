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
# ULT_MODIFIC:  26/01/19
#
verifica_internet()
{
	ping_server="www.google.com"
	
  	ping -c1 $ping_server >> /dev/null
  	[[ ! $? -eq 0 ]] && echo "Sem internet" && exit 1
}

radio()
{
	declare -A STREAM
	
	STREAM=(	
	["Mission Control"]="http://ice1.somafm.com/missioncontrol-128-aac"
	["Space Station"]="http://ice1.somafm.com/spacestation-128-aac"
	["Deep Space One"]="http://ice1.somafm.com/deepspaceone-128-aac"
	["Sonic Universe"]="http://ice1.somafm.com/sonicuniverse-128-aac"
	["Indie Pop"]="http://ice1.somafm.com/indiepop-128-aac"
	)

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
	verifica_internet
	radio
}

main