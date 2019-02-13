#!/usr/bin/env bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # # 
#
# por lenonr(Lenon Ricardo) 
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#	If I have seen further it is by standing on the shoulders of Giants.		#
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)				#
#							~Isaac Newton										#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:              [0.0.50]       #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [13/02/19]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
## Compativel em
#	Debian Stable
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# 
# # FUNCOES
# # # # # # # # # #    
# # DADOS DO SISTEMA
# 
install_system=$(ls -lct /etc | tail -1 | awk '{print $6, $7, $8}')
date_now=$(date +%x-%k%M)
sistema=$(hostname)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#                               CORPO DO SCRIPT                               	#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
neofetch_sistema()
{
	# neofetch

	neofetch --cpu_temp 'on' --memory_display bar --color_blocks off --cpu_cores 'physical'
}

memoria_utilizada()
{
    # free -hmt ; echo

    echo "- Memoria livre total: $(free -ht | awk '/Total:/ {print $4}')" ; echo
}

disco()
{
	# df -h / ; echo
	# df -h /home ; echo

	echo "- Uso da raiz do usuario root: $(df -h / | awk '/dev/sda1 {print $5}' | tail -1)" ; echo 

	echo "- Uso da raiz do usuario $(whoami): $(df -h /home | awk '/dev/sda1 {print $5}' | tail -1)" ; echo 
}

instalacao_sistema()
{
	echo "- Sistema instalado em $install_system"
}

commits()
{
	# export COMMITS
	
	if [[ $COMMITS = "" ]]; then
		echo "- ERROR"
	elif [[ $COMMITS = "0" ]]; then
		echo "- Voce nao possui commits pendentes!"
	else
		echo "- Voce possui $COMMITS commits, pendentes!"	
	fi

	echo
}

relatorio()
{
	echo "######### RELATORIO DO SISTEMA #########"
	memoria_utilizada
	disco
	commits
	instalacao_sistema	
	echo "########################################"
}

################################################
completo()
{	
	neofetch_sistema	
	relatorio
	echo
}

echo_p()
{
	if [[ $sistema = "notebook" ]]; then
		echo "##########################################################################"
	else
		echo "###############################################################################"
	fi
}

main()
{	
	clear 

	echo_p

	if [[ $1 == "" ]]; then
		echo "Parametros disponiveis:"
		echo "-n: neofetch"
		echo "-d: disco"
		echo "-m: memoria utilizada"	
		echo "-i: visualiza data que o sistema foi instalado"	
		echo "-a: completo"
	elif [[ $1 == "-a" ]]; then
		completo
	elif [[ $1 == "-n" ]]; then
		neofetch_sistema
	elif [[ $1 == "-d" ]]; then
		disco
	elif [[ $1 == "-m" ]]; then
		memoria_utilizada
	elif [[ $1 == "-i" ]]; then
		instalacao_sistema
	elif [[ $sistema == "notebook" ]]; then		
		neofetch_sistema
	else
		completo
	fi
	
	echo_p
}
    
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
main $1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 