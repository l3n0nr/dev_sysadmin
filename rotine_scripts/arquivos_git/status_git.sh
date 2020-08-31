#!/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
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
# Date create script:    	  		[08/04/18]       #
# Last modification script: 		[11/04/19]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/l3n0nr/Github/dev_sysadmin/rotine_scripts/arquivos_git/variables.conf
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# verificando se existem repositorios modificados
contador=0

## arquivos de saida
saida_add="/tmp/commit_add.txt"
saida_com="/tmp/commit_com.txt"

check_files()
{
	if [[ -e $saida_add ]]; then
		touch $saida_add
	fi

	if [[ -e $saida_com ]]; then
		touch $saida_com
	fi

	## zerando arquivos
	echo > $saida_add
	echo > $saida_com
}

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

					git status | grep "Changes not" > /dev/null
						
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						# show folder status
						echo "[+] Repositorio ${repos[$i]}"						
						echo "#########################################################"
						git status						
						echo "#########################################################"							

						if [[ $1 == "-on" ]]; then
							notify-send "| ${repos[$i]} - ADD |"	
						fi				

						printf "${repos[$i]} " >> $saida_add 		

						## contador
						let contador++	
						let contador_add++

						echo $contador_add > /tmp/commits_add					
					fi				

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
						if [[ $1 == "-on" ]]; then
							notify-send "| ${repos[$i]} - COM |"
						fi																		

						printf "${repos[$i]} " >> $saida_com

						## contador
						let contador++
						let contador_com++

						echo $contador_com > /tmp/commits_com
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

		if [[ $contador != "0" ]]; then
			echo $contador > /tmp/commits
		fi		

		fi			
	done	
}

push_auto()
{
	## chamando arquivo para commit automatico
	source /home/l3n0nr/Github/dev_sysadmin/rotine_scripts/arquivos_git/push_git.sh
}

main()
{
	check_files
	status_git $1
	check_git $1
}

main $1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #