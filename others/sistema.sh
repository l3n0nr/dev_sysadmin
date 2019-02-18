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
## REFERENCIAS
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# 	
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:              [0.0.100]      #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [18/02/19]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
## COMPATIVEL COM
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
	neofetch --disable terminal resolution memory --color_blocks off --gtk3 off ; echo
}

memoria_utilizada()
{
    echo "- Memoria RAM livre: $(free -h | awk '/Mem/ {print $4}') / $(free -h | awk '/Mem/ {print $2}')." ; echo
}

disco()
{
	echo "- Uso da raiz do usuario root: $(df -h / | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 

	echo "- Uso da raiz do usuario $(whoami): $(df -h /home | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 
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
		echo "- Voce nao possui repositorios pendentes!"
	elif [[ $commits = "1" ]]; then
		echo -e "\e[1;34m- Voce possui 1 repositorio pendente! \e[0m"
	else
		echo -e "\e[1;34m- Voce possui $commits repositorios pendentes! \e[0m"
	fi

	echo
}

check_commit()
{
	if [[ ! -e "/tmp/commits"  ]]; then
		touch /tmp/commits
		echo "0" > /tmp/commits		
	fi		

	echo "0" > /tmp/commits

	source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh >> /dev/null 
}

check_updates()
{
	arquivo_verifica="/tmp/checa_atualizacao"

	if [[ ! -e $arquivo_verifica  ]]; then
		touch $arquivo_verifica
		echo "" > $arquivo_verifica
	fi		

	verifica=$(cat $arquivo_verifica)

	if [[ $verifica != "Listing..." ]]; then
		echo -e "\e[1;31m- Atualizaçoes de programas disponiveis! \e[0m" ; echo
	else
		echo "- Tudo atualizado!" ; echo
	fi	
}

report()
{
	if [[ $sistema = "notebook" ]]; then
		echo "############################# SYSTEM REPORT ##############################"
	else
		echo "################################ SYSTEM REPORT ################################"
	fi
	echo
	memoria_utilizada
	disco
	commits	
	check_updates
	instalacao_sistema
	echo	
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
	completo	
	
	echo_p
}
    
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
main $1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Black        0;30     Dark Gray     1;30
	# Red          0;31     Light Red     1;31
	# Green        0;32     Light Green   1;32
	# Brown/Orange 0;33     Yellow        1;33
	# Blue         0;34     Light Blue    1;34
	# Purple       0;35     Light Purple  1;35
	# Cyan         0;36     Light Cyan    1;36
	# Light Gray   0;37     White         1;37