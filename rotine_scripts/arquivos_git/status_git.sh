#!/usr/bin/env bash
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
# Last modification script: 		[24/06/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf

# verificando se existem repositorios modificados
contador=0

## chamando funcao
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

						let contador++
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

	date >> /tmp/repo.txt
}

check_git()
{
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
					git status | grep "to publish your local commits" > /dev/null
  											
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						notify-send "Voce precisa commitar, ${repos[$i]}!"

						let contador++
					fi														
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

	if [[ $contador == "0" ]]; then
		notify-send "Nada para commitar!!"
	fi
}

push_auto()
{
	## chamando arquivo para commit automatico
	source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/push_git.sh
}

main()
{
	status_git	

	[[ $@ == "check" ]] && check_git && exit 0
}

main $1 


### RODAPE

## verificar menu
# status_git	
# [[ $@ == "" ]] && status_git && exit 0 ||
# [[ $@ == "check" ]] && check_git && exit 0 || \
# # [[ $@ == "push" ]] && push_auto && exit 0 || \
# echo "nao entendi" && exit 1
