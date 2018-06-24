#/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # #
#   DEVELOPMENT BY 	  #
# # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Last modification script: 		[23/06/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf

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
		echo "Parametros disponiveis: $repos"
		exit 1
	else 		
		# chamando funcao
		auto_alias $1		
	fi
}

# iniciando script
menu $1