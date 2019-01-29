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
# ULT_MODIFIC:  29/01/19
# VERSAO:		0.38
#
verifica_internet()
{
	echo "Verificando conexao, aguarde..."
	clear 

	ping_server="www.google.com"
	
  	ping -c1 $ping_server >> /dev/null
  	[[ ! $? -eq 0 ]] && echo "SEM CONEXAO!" && exit 1
}

radio()
{
	declare -A STREAM
	
	local="/home/lenonr/Github/dev_sysadmin/others/radio"

	source $local/radio.conf

	PS3=$'\nSelecione uma radio:'
	select radio in "${!STREAM[@]}"; do
		title="${radio}"
		ip="${STREAM[$radio]}"
		echo -e "\033[31;1mVoce esta ouvindo: $title (Ctrl+C para sair)\033[m"
		ffplay -nodisp $ip &> /dev/null
	done
}

radio_dialog()
{

	declare -A STREAM
	
	local="/home/lenonr/Github/dev_sysadmin/others/radio"

	source $local/radio.conf
	
	# for (( i = 0; i <= ${!STREAM[@]}; i++ )); do  
	# 	name = "${i}"
	# 	ip   = "${STREAM[$i]}"
	# done

	# select radio in "${!STREAM[@]}"; do
		# title="${radio}"
		# ip="${STREAM[$radio]}"
		# echo -e "\033[31;1mVoce esta ouvindo: $title (Ctrl+C para sair)\033[m"
		# ffplay -nodisp $ip &> /dev/null\

		# PS3=$(dialog \
	 #            --stdout --ok-label "Ouvir" --cancel-label "Cancelar" \
	 #            --menu "Escolha uma radio:" \
	 #            0 0 0 \
	 #            "${radio}" "${STREAM[$radio]}")
	# done	
}

main()
{
	clear
	verifica_internet
	radio
	# radio_dialog
}

main