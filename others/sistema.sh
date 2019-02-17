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
# # versão do script:              [0.0.95]       #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [17/02/19]      #
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
		echo "- Voce possui 1 repositorio pendente!"
	else
		echo "- Voce possui $commits repositorios pendentes!"	
	fi

	echo
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
	instalacao_sistema
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