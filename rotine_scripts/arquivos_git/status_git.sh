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
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Date create script:    	  		[08/04/18]       #
# Last modification script: 		[20/06/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# # variaveis
# pasta dos repositorios
local='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)		# repositorios

status_git()
{
	clear

	# # walk to the array
	for (( i = 0; i <= ${#repos[@]}; i++ )); do	
		# verify local repo disk
		if [[ $local${repos[$i]} != $local ]]; then
			# verify local repo
			if [ -e "$local${repos[$i]}" ]; then 	  	 
				# if update repositorie work
			  	if [[ $? == "0" ]]; then
		  			# into folder location
				  	cd $local${repos[$i]}			  								

					# check status
					# changes=$(git status | grep "Changes not" > /dev/null)
					git status | grep "Changes not" > /dev/null
						
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						# show folder status
						echo "[~] Repositorio ${repos[$i]}"						
						echo "#########################################################"
						git status						
						echo "#########################################################"							

						# chamando script externo
						# $(auto_alias.sh) ${repos[$i]}
					else
						printf ""
					fi				

					# untrack=$(git status | grep "Untracked files:" > /dev/null)
					git status | grep "Untracked files:" > /dev/null

					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						#show folder status
						echo "[~] Repositorio ${repos[$i]}"
						echo "#########################################################"
						git status
						echo "#########################################################"
					else
						printf ""
					fi			
					
				# if update repositorie not work		
			  	else				  		
					echo "repositorie Error ${repos[$i]}!" >> /tmp/repo.txt
			  	fi				
				
				# add  
			  	let repo_founds++		

			  	printf "\n" >> /tmp/repo.txt  	
			else
				date >> /tmp/repo.txt
				echo "[-] - Not found": $local${repos[$i]}

				# repo_notfounds=$(($repo_notfounds + 1));        
				let repo_notfounds++
			fi
		fi		
	done
}

status_git

# echo "[~] Atual $(pwd)" 

# data do final do script
date >> /tmp/repo.txt