#!/bin/zsh

local_repo='/home/lenonr/Github/'			

# # repositorios
var_alias=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)	

# chamando script de configuracao	
# source config_git.sh

auto_alias()	
{		
	# percorre vetor
	for (( i = 0; i <= ${#var_alias[@]}; i++ )); do	
		# se parametro for igual ao vetor
		if [[ $1 == ${var_alias[$i]} ]]; then						
			cd $local_repo${var_alias[$i]}			

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
	# se variavel for vazia, mostra mensagem e sai
	if [[ -z $1 ]]; then
		echo "Parametros disponiveis: $var_alias"
		exit;
	else 		
		# chamando funcao
		auto_alias $1		
	fi
}

# limpando a tela
clear

# iniciando script
menu $1