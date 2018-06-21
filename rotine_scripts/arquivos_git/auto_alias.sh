#!/bin/bash

# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf

# # pasta dos repositorios
# local="/home/lenonr/Github/"		

# # repositorios disponiveis
# repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)		

auto_alias()	
{		
	# percorre vetor
	for (( i = 0; i <= ${#repos[@]}; i++ )); do	
		# se parametro for igual ao vetor
		if [[ $1 == ${repos[$i]} ]]; then						
			cd $local${repos[$i]}			

			echo "########## MODIFICAÇOES ###############" 
			printf "\n"			
			git status					
			printf "\n"			
			echo "########## LISTA DE ARQUIVOS ##########" 
			printf "\n"
			ls
			printf "\n"
			echo "######################################"	
		fi					  						 			
	done
}

menu()
{
	# limpando a tela
	clear		
	
	# se variavel for vazia, mostra mensagem e sai
	if [[ -z $1 ]]; then
		echo "Parametros disponiveis: $repos"
		exit;
	else 		
		# chamando funcao
		auto_alias $1		
	fi
}

# iniciando script
menu $1