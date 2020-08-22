#!/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # #
#   DEVELOPMENT BY 	  #
# # # # # # # # # # # #
#
# por l3n0nr(Lenon Ricardo)
#       contato: <l3n0nrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Last modification script: 		[16/03/20]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/l3n0nr/Github/dev_sysadmin/rotine_scripts/arquivos_git/variables.conf

auto_alias()	
{		
	# percorre vetor
	for (( i = 1; i <= ${#repos[@]}; i++ )); do	
		## encurtando vetor
		valor=${repos[$i]} 
		parametro=$(echo $valor | sed -e "s;dev_;;g")
		
		# se parametro for igual ao vetor
		if [[ $1 == $parametro ]]; then						
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
		echo "##### Opções #####"		
		for (( i = 1; i <= ${#repos[@]}; i++ )); do	
			echo "~ repo" $repos[i] | sed -e "s;dev_;;g"
		done		
		echo "##################"
	else 		
		# chamando funcao
		auto_alias $1		
	fi
}

# iniciando script
menu $1