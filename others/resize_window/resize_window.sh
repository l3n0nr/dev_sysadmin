#!/usr/bin/env bash
#
########################
# DATA_CRIACAO: 23/03/19
# ULT_MODIFIC : 24/03/19
# VERSAO 	  : 0.20
########################
#
## REFERENCE
# 	https://www.semicomplete.com/projects/xdotool/
#	https://superuser.com/questions/196532/how-do-i-find-out-my-screen-resolution-from-a-shell-script
#
## CHECK
# 	Spotify
# 	Janelas multiplas do mesmo programa(sobreposicao estranha na tela)
#

## chama arquivo externo
source resolution.sh

check()
{
	WIDS=`xdotool search --onlyvisible --name "$1"`

	for id in $WIDS; do
	  xdotool windowsize $id $calc_width $calc_height
	  xdotool windowmove -- $id 70 70
	done
}

main()
{
	## chama funcao externa
	resolution	

	if [[ $1 = "" ]]; then
		echo "ERROR: É necessário passar o nome da aplicativo como parametro!"
		exit 1
	else
		check $1
	fi
}

main $1