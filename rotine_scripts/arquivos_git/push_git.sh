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
# Date create script:    	  		[08/04/18]       #
# Last modification script: 		[21/04/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#

# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf

push_git()
{
	clear

	# # walk to the array
	for (( i = 0; i <= ${#repos[@]}; i++ )); do	
		# verify local repo disk
		if [[ $local${repos[$i]} != $local ]]; then
			# verify local repo
			if [ -e "$local${repos[$i]}" ]; then 
				# into folder location
				cd $local${repos[$i]}			  					

				git status | grep "to publish your local commits" >> /dev/null

				if [[ $? == "0" ]]; then
					# if update repositorie work
				  	if [[ $? == "0" ]]; then			  									
						echo "Subindo modicaçoes em $local${repos[$i]}"
						git push

						printf "\n"
					# if update repositorie not work		
				  	else				  		
						echo "repositorie Error ${repos[$i]}!" >> /tmp/repo.txt
				  	fi									
				# else
				# 	echo "Nenhum push pendente em $local${repos[$i]}\n"
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

	# data do final do script
	date >> /tmp/repo.txt
}

push_git