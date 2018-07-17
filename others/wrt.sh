#!/usr/bin/env bash

# Descricao: Chama telnet do roteador via alias

wrt()
{
    local_wrt='10.0.0.87'

  	# verificando conexao
  	ping -c1 $local_wrt

  	clear 

  	# verificando se diretorio existe 
  	if [ $? -eq 0 ]; then
  		echo "########################"
  		printf "CONECTANDO AO SERVIDOR\n"
  		echo "########################\n"
	  	telnet $local_wrt
  	else
		echo "IP do servidor '$local_wrt' nao encontrado"
	fi
}

main()
{
  wrt
}

## chamando funcao
main