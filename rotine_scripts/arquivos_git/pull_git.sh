#!/bin/zsh
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # #
#   DEVELOPMENT BY 	  #
# # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#									      									  #
#	If I have seen further it is by standing on the shoulders of Giants.      #
#							~Isaac Newton	      							  #
#									      									  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Date create script:    	  		[30/03/18]       #
# Last modification script: 		[21/04/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #

# # variaveis
# pasta dos repositorios
LOCAL='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
REPOS=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)		# repositorios

internet()
{
	ping -c1 google.com > /dev/null

	if [ $? = "0" ]; then		
		pull_git
	else			
		# echo "Verificar internet!"
		exit
	fi	
}

pull_git()
{
	# # walk to the array
	for (( i = 1; i <= ${#REPOS[@]}; i++ )); do	
		# verify local repo disk
		if [[ $LOCAL${REPOS[$i]} != $LOCAL ]]; then
			# verify local repo
			if [ -e "$LOCAL${REPOS[$i]}" ]; then 	  	 
				date >> /tmp/repo.txt
			  	echo "[+] - Atualizando repositorio:" $LOCAL${REPOS[$i]} >> /tmp/repo.txt

			  	# into folder location
			  	cd $LOCAL${REPOS[$i]}

			  	# update repositories
			  	git pull >> /tmp/repo.txt

			  	# if update repositorie not work
			  	if [[ $? == "0" ]]; then
					# echo "Repositorie ${REPOS[$i]} fine!" >> /tmp/repo.txt
			  	else				  		
					echo "Repositorie Error ${REPOS[$i]}!" >> /tmp/repo.txt
			  	fi

			  	# REPO_FOUNDS=$(($REPO_FOUNDS + 1));        
			  	let REPO_FOUNDS++		

			  	printf "\n" >> /tmp/repo.txt  	
			else
				date >> /tmp/repo.txt
				echo "[-] - Not found": $LOCAL${REPOS[$i]}

				# REPO_NOTFOUNDS=$(($REPO_NOTFOUNDS + 1));        
				let REPO_NOTFOUNDS++
			fi
		fi
	done	
}

# data de inicio do script
echo "Inicio do script" > /tmp/repo.txt
date > /tmp/repo.txt
printf "\n" >> /tmp/repo.txt

# chamando funcao
internet

# data do final do script
date >> /tmp/repo.txt