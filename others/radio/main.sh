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
# ULT_MODIFIC:  20/02/19
# VERSAO:		0.48
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
		# echo "Saindo.."
		exit 0
	else
		# printf "\nTocando: $escolha.."
		dialog --infobox "$escolha" 0 0
	fi
}

radio_dialog()
{
	escolha=$(dialog \
            --stdout --ok-label "Ouvir" --cancel-label "Sair" \
            --menu "Escolha uma radio:" \
            0 0 0 \
            "Dronezone" "1" \
            "Space Station" "2" \
            "Deep Space One" "3" \
            "Radio Gaucha" "4" \
            "Mission Control" "5" \
            "Digitalis" "6" \
            "Indie Pop" "7" \
            "DEFCon" "8" \
            "Minuano" "9" \
            "Nativa" "10" \
            "Atlantida" 11 ) ; 

    func_verifica && func_radio
}

func_radio()
{
	declare -A STREAM
	
	local="/home/lenonr/Github/dev_sysadmin/others/radio"

	source $local/radio.conf

	title="${escolha}"
	ip="${STREAM[$escolha]}"
	ffplay -nodisp $ip &> /dev/null
	radio_dialog
}

###########################################################################
main()
{
	clear
	verifica_internet
	# radio
	radio_dialog
}
###########################################################################

main