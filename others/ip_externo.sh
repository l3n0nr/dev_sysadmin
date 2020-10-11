#!/usr/bin/env bash

func_verifica_internet()
{
	ping_server="google.com"

	# verificando internet
  	# se nao tiver internet, fecha script
  	ping -c1 $ping_server >> /dev/null

  	if [[ $? -eq 0 ]]; then
  		clear
  		printf "IP:" && curl icanhazip.com
  	else
  		clear
  		echo "Sem conexao"
  	fi
}

main()
{
	func_verifica_internet
}

main

