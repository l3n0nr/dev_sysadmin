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
# 	<https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux>
# 	<https://stackoverflow.com/questions/3385003/shell-script-to-get-difference-in-two-dates>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:              [1.45]         #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [16/03/20]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  
source variables.conf
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#                               CORPO DO SCRIPT                               	#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
neofetch_sistema()
{
	neofetch --disable de wm theme icons memory resolution --color_blocks off ; echo
}

memoria_utilizada()
{
    echo "- Memoria RAM livre: $(free -h | awk '/Mem/ {print $4}') / $(free -h | awk '/Mem/ {print $2}')." ; echo
}

disco()
{
	echo "- Uso da raiz do root: $(df -h / | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 

	echo "- Uso da raiz do $(whoami): $(df -h /home | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 
}

instalacao_sistema()
{	
	echo "- Sistema instalado em $install_system."
}

commits()
{
	check_commit	

	if [[ $commits = "" ]]; then
		echo "- ERROR"
	elif [[ $commits = "0" ]]; then
		echo "- Voce nao possui acoes pendentes no GIT!"
	elif [[ $commits = "1" ]]; then
		echo -e "\e[1;31m- Voce possui 1 açao pendente no GIT. \e[0m"
	else
		echo -e "\e[1;31m- Voce possui $commits açoes pendentes no GIT. \e[0m"
	fi

	commits_add
	commits_com
}

commits_add()
{
	if [[ $commits_add > "0" ]]; then
		if [[ $cont_add = "" ]]; then
			echo -e "\e[1;34m 	ADD: $commits_add\e[0m"	
		else
			echo -e "\e[1;34m 	ADD: $commits_add [ $cont_add]\e[0m"	
		fi		
	fi
}

commits_com()
{	
	if [[ $commits_com > "0" ]]; then
		if [[ $cont_com = "" ]]; then
			echo -e "\e[1;34m 	COM: $commits_com\e[0m"	
		else
			echo -e "\e[1;34m 	COM: $commits_com [ $cont_com]\e[0m"	
		fi
		
	fi

	echo
}

check_commit()
{
	if [[ ! -e $output_commits ]]; then
		touch $output_commits
	else
		echo "0" > $output_commits
	fi		

	if [[ ! -e $output_commits_add  ]]; then
		touch $output_commits_add
	else
		echo "0" > $output_commits_add
	fi		

	if [[ ! -e $output_commits_com  ]]; then
		touch $output_commits_com
	else
		echo "0" > $output_commits_com
	fi			

	source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh >> /dev/null 
}

check_updates()
{	
	if [[ ! -e $arquivo_verifica  ]]; then
		touch $arquivo_verifica
		echo "" > $arquivo_verifica
	fi		

	verifica=$(cat $arquivo_verifica)

	if [[ $verifica == "" ]] || [[ $verifica == "Listing..." ]]; then
		echo "- Tudo atualizado!" ; echo
	else
		conta=$(wc /tmp/checa_atualizacao | awk {'print $1'-1})

		if [[ $conta > 1 ]]; then
			echo -e "\e[1;31m- $conta atualizaçoes disponiveis! \e[0m" ; echo
		else
			echo -e "\e[1;31m- 1 atualizaçao disponivel! \e[0m" ; echo					
		fi		
	fi	
}

report()
{
	if [[ $sistema = "notebook" ]]; then
		echo "######################## SYSTEM REPORT ##########################"
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
		echo "########################### NEOFETCH ############################"
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
		echo "#################################################################"
	else
		echo "###############################################################################"
	fi
}

print_output()
{
	if [[ ! -e $output ]]; then
		touch $output
	fi

	completo > $output
	cat $output	
}

main()
{	
	clear 
		
	print_output	
	echo_p
}
    
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
main