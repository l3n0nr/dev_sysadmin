#!/bin/bash
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
local='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)		# repositorios

# endereco de teste
ping_end="google.com"

internet()
{
	ping -c1 $ping_end > /dev/null

	if [ $? == "0" ]; then		
		pull_git
	else			
		zenity --info \
			   --width "300" \
			   --height "50" \
			   --text "Verificar a internet! - pull_git"
		exit 1
	fi	
}

pull_git()
{
	# data de inicio do script
	echo "Inicio do script" > /tmp/repo.txt
	date > /tmp/repo.txt
	printf "\n" >> /tmp/repo.txt

	# # walk to the array
	for (( i = 1; i <= ${#repos[@]}; i++ )); do	
		# verify local repo disk
		if [[ $local${repos[$i]} != $local ]]; then
			# verify local repo
			if [ -e "$local${repos[$i]}" ]; then 	  	 
				date >> /tmp/repo.txt
			  	echo "[+] - Atualizando repositorio:" $local${repos[$i]} >> /tmp/repo.txt

			  	# into folder location
			  	cd $local${repos[$i]}

			  	# update repositories
			  	git pull >> /tmp/repo.txt

			  	# if update repositorie not work
			  	if [[ $? == "0" ]]; then
					# echo "repositorie ${repos[$i]} fine!" >> /tmp/repo.txt
			  	else				  		
					echo "repositorie Error ${repos[$i]}!" >> /tmp/repo.txt
			  	fi

			  	# REPO_FOUNDS=$(($REPO_FOUNDS + 1));        
			  	let REPO_FOUNDS++		

			  	printf "\n" >> /tmp/repo.txt  	
			else
				date >> /tmp/repo.txt
				echo "[-] - Not found": $local${repos[$i]}

				# REPO_NOTFOUNDS=$(($REPO_NOTFOUNDS + 1));        
				let REPO_NOTFOUNDS++
			fi
		fi
	done	

	# data do final do script
	date >> /tmp/repo.txt
}

# chamando funcao
# internet
pull_git