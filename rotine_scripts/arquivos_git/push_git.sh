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
# Last modification script: 		[12/04/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# # variaveis
# pasta dos repositorios
LOCAL='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo)		# repositorios

push_git()
{
	clear

	# # walk to the array
	for (( i = 1; i <= ${#repos[@]}; i++ )); do	
		# verify local repo disk
		if [[ $LOCAL${repos[$i]} != $LOCAL ]]; then
			# verify local repo
			if [ -e "$LOCAL${repos[$i]}" ]; then 
				# into folder location
				cd $LOCAL${repos[$i]}			  					

				git status | grep "to publish your local commits" >> /dev/null

				if [[ $? == "0" ]]; then
					# if update repositorie work
				  	if [[ $? == "0" ]]; then			  									
						echo "Subindo modicaçoes em $LOCAL${repos[$i]}"
						git push

						printf "\n"
					# if update repositorie not work		
				  	else				  		
						echo "repositorie Error ${repos[$i]}!" >> /tmp/repo.txt
				  	fi									
				else
					echo "Nenhum push pendente em $LOCAL${repos[$i]}\n"
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
	done		
}

push_git

# data do final do script
date >> /tmp/repo.txt