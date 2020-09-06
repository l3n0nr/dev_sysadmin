#!/usr/bin/env bash
#
##########################################
#
# DESCRICAO: Toca web radio no terminal
# AUTOR: 	 lenonr | lenonrmsouza@gmail
#
##########################################
#
# DATA_CRIACAO: 26/01/19
# ULT_MODIFIC:  04/12/19
# VERSAO:		1.37
#
##########################################
#
## VARIAVEIS
path="/home/lenonr/Github/dev_sysadmin/others/radio"
ping_server="www.google.com"

verifica_internet()
{
	clear 

	echo "Verificando conexao, aguarde..."		
	
  	ping -c1 $ping_server >> /dev/null
  	[[ ! $? -eq 0 ]] && echo "SEM CONEXAO!" && exit 1 || clear
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
            --menu "Selecione um gênero:" 0 0 0 \
            "Brasil" "+" \
            "SomaFM" "-" \
            "Others" "*" ) ; 
		
    func_verifica && radio_dialog
}

radio()
{
	declare -A STREAM

	source $path/radio.conf

	PS3=$'\nSelecione uma radio:'
	select radio in "${!STREAM[@]}"; do		
		title="${radio}"
		ip="${STREAM[$radio]}"
		ffplay -nodisp $ip &> /dev/null
	done
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
			"Jovem Pan" "+" \
			"Cafe Brasil" "+" ) ; 

    func_volta && func_radio_brasil 
}

radio_dialog_somafm()
{
	escolha=$(dialog \
	    --stdout --ok-label "Ouvir" --cancel-label "Voltar" \
	    --menu "Escolha uma radio:" 0 0 0 \
	    "Dronezone" "-" \
	    "Space Station" "-" \
	    "Digitalis" "-" \
	    "Deep Space One" "-" \
	    "Mission Control" "-" \
	    "Indie Pop" "-" \
	    "Lush" "-" \
	    "Groove Salad" "-" \
	    "u80s" "-" \
	    "Secret Agent" "-" \
	    "Sonic Universe" "-" \
	    "Beat Blender" "-" ) ;         

	func_volta && func_radio_somafm
}

radio_dialog_others()
{
	escolha=$(dialog \
	    --stdout --ok-label "Ouvir" --cancel-label "Voltar" \
	    --menu "Escolha uma radio:" 0 0 0 \
	    "Abiding" "*" \
	    "440 Rock" "*" \
	    "Smooth Jazz" "*" \
	    "Classical" "*" \
	    "Ambient" "*" \
	    "Al-Radio" "*" \
	    "Wonderful London" "*" ) ;   

	func_volta && func_radio_others
}

radio_dialog()
{	
	if [[ $local = "Brasil" ]]; then
		radio_dialog_brasil
	elif [[ $local = "SomaFM" ]]; then
		radio_dialog_somafm
	elif [[ $local = "Others" ]]; then
		radio_dialog_others
	else
		select_local
	fi
}

func_radio_brasil()
{
	declare -A STREAM
	
	source $path/radio_brasil.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog_brasil
}

func_radio_somafm()
{
	declare -A STREAM
	
	source $path/radio_somafm.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog_somafm
}

func_radio_others()
{
	declare -A STREAM
	
	source $path/radio_others.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog_others
}

###########################################################################
main()
{	
	verifica_internet
	select_local
}
###########################################################################

main