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
# # versão do script:              [0.0.70]       #
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

	neofetch --disable terminal resolution memory --color_blocks off --distro_shorthand 'tiny' --gtk3 off
	echo

}

memoria_utilizada()
{
    # free -hmt ; echo

    echo "- Memoria RAM livre: $(free -h | awk '/Mem/ {print $4}')" ; echo
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
	commits=$(cat /tmp/commits)

	if [[ $commits = "" ]]; then
		echo "- ERROR"
	elif [[ $commits = "0" ]]; then
		echo "- Voce nao possui commits pendentes!"
	elif [[ $commits = "1" ]]; then
		echo "- Voce possui 1 commit pendente!"
		# echo -e "\e[0;91m- Voce possui 1 commit pendente!"
	else
		echo "- Voce possui $commits commits, pendentes!"	
	fi

	echo
}

report()
{
	if [[ $sistema = "notebook" ]]; then
		# echo "##########################################################################"
		echo "############################# SYSTEM REPORT ##############################"
	else
		# echo "###############################################################################"
		echo "################################ SYSTEM REPORT ################################"
	fi
	echo
	memoria_utilizada
	disco
	commits
	instalacao_sistema
	echo	
}

check_commit()
{
	if [[ ! -e "/tmp/commits"  ]]; then
		touch /tmp/commits
		echo "0" > /tmp/commits
		source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh >> /dev/null 
	fi		
}

################################################
completo()
{	
	if [[ $sistema = "notebook" ]]; then
		echo "################################ NEOFETCH ################################"
		echo
	else
		echo "################################### NEOFETCH ##################################"
		echo
	fi

	neofetch_sistema	
	report
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

	check_commit

	# echo_p		

	if [[ $1 == "" ]]; then
		echo "Parametros disponiveis:"
		echo "-n: neofetch"
		echo "-d: disco"
		echo "-m: memoria utilizada"	
		echo "-i: visualiza data que o sistema foi instalado"	
		echo "-r: report do sistema"
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
	elif [[ $1 == "-r" ]]; then
		report
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