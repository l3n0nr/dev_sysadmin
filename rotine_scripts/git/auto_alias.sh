#!/bin/zsh

# local_repo='/home/lenonr/Github/'			

# # repositorios
# var_alias=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo)	

auto_alias()	
{		
	# percorre vetor
	for (( i = 0; i <= ${#var_alias[@]}; i++ )); do	
		# se parametro for igual ao vetor
		if [[ $1 == ${var_alias[$i]} ]]; then						
	 		entra_pasta=$local_repo${var_alias[$i]}	
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

		#abrindo pasta posteriormente
		echo "########## LISTA DE ARQUIVOS ##########" 
		cd $entra_pasta
		ls
		echo "######################################"	
	fi
}

# limpando a tela
clear

# chamando script de configuracao	
./config_git.sh

# iniciando script
menu $1