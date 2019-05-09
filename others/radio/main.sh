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
# ULT_MODIFIC:  09/05/19
# VERSAO:		1.28
#
###########################################################################
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

func_verifica()
{
	if [[ $? == "1" ]]; then
		exit 0
	else
		dialog --infobox "$escolha" 0 0
	fi
}

func_volta()
{
	if [[ $? == "1" ]]; then
		main
	else
		dialog --infobox "$escolha" 0 0
	fi
}

select_local()
{
	local=$(dialog \
            --stdout --ok-label "Ouvir" --cancel-label "Sair" \
            --menu "Escolha um local:" 0 0 0 \
            "Brasil" "+" \
            "Others" "-" ) ; 
		
    func_verifica && radio_dialog
}

radio_dialog_brasil()
{
	escolha=$(dialog \
			--stdout --ok-label "Ouvir" --cancel-label "Voltar" \
			--menu "Escolha uma radio:" 0 0 0 \
			"Gaucha" "+" \
			"USP" "+" \
			"UFRGS" "+" \
			"Bandeirantes" "+" \
			"Minuano" "+" \
			"Nativa" "+" \
			"Atlantida" "+" \
			"Jovem Pan" "+" ) ; 

    func_volta && func_radio_brasil 
}

radio_dialog_others()
{
	escolha=$(dialog \
	    --stdout --ok-label "Ouvir" --cancel-label "Voltar" \
	    --menu "Escolha uma radio:" 0 0 0 \
	    "Dronezone" "-" \
	    "Space Station" "-" \
	    "Digitalis" "-" \
	    "Deep Space One" "-" \
	    "Mission Control" "-" \
	    "Indie Pop" "-" ) ;         

	func_volta && func_radio_others
}

radio_dialog()
{
	if [[ $local = "Brasil" ]]; then
		radio_dialog_brasil
	elif [[ $local = "Others" ]]; then
		radio_dialog_others
	else
		select_local
	fi
}

func_radio_brasil()
{
	declare -A STREAM
	
	local="/home/lenonr/Github/dev_sysadmin/others/radio"

	source $local/radio_brasil.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog_brasil
}

func_radio_others()
{
	declare -A STREAM
	
	local="/home/lenonr/Github/dev_sysadmin/others/radio"

	source $local/radio_others.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog_others
}

###########################################################################
main()
{
	clear
	verifica_internet
	select_local
}
###########################################################################

main