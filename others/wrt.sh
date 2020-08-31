#!/usr/bin/env bash

# DESCRICAO
#   Chama telnet do roteador via alias

# ULT_MOD = 03/06/19

local_wrt='192.168.1.1'

wrt()
{    
    # verificando conexao
    ping -c1 $local_wrt >> /dev/null  

  	# verificando se diretorio existe 
  	if [ $? -eq 0 ]; then
  		printf "########################"
  		printf "\nCONECTANDO AO SERVIDOR\n"
  		printf "########################\n"
	  	telnet $local_wrt
  	else
		  echo "IP do servidor '$local_wrt' nao encontrado"
	fi
}

main()
{
  clear

  wrt
}

## chamando funcao
main