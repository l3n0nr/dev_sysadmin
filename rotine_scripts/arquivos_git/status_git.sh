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
# Last modification script: 		[11/04/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# # variaveis
# pasta dos repositorios
LOCAL='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo)		# repositorios

status_git()
{
	clear

	# # walk to the array
	for (( i = 1; i <= ${#repos[@]}; i++ )); do	
		# verify local repo disk
		if [[ $LOCAL${repos[$i]} != $LOCAL ]]; then
			# verify local repo
			if [ -e "$LOCAL${repos[$i]}" ]; then 	  	 
				# if update repositorie work
			  	if [[ $? == "0" ]]; then
		  			# into folder location
				  	cd $LOCAL${repos[$i]}			  					

					# check status
					git status | grep "Changes not" > /dev/null
						
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						# show folder status
						# echo "Modificaçao necessaria: $LOCAL${repos[$i]}"
						echo "#########################################################"
						git status
						echo "#########################################################"
						printf "\n" 						
						ls
						printf "\n"
						echo "#########################################################"

						break;						
					else
						printf ""
					fi				

					git status | grep "Untracked files:" > /dev/null

					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						#show folder status
						echo "Modificaçao necessaria: $LOCAL${repos[$i]}"
						echo "#########################################################"
						git status

						break;
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
				echo "[-] - Not found": $LOCAL${repos[$i]}

				# repo_notfounds=$(($repo_notfounds + 1));        
				let repo_notfounds++
			fi
		fi

		if [[ $? == "" ]]; then
			echo "Nada para mostrar"
		fi
	done		
}

status_git

# data do final do script
date >> /tmp/repo.txt