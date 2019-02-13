#!/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
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
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
# Date create script:    	  		[08/04/18]       #
# Last modification script: 		[12/12/18]       #
# # # # # # # # # # # # # # # # # # # # # # # ## # # #
#
# chamando arquivo de configuracao
source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/git.conf
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
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

					git status | grep "Changes not" > /dev/null
						
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						# show folder status
						echo "[+] Repositorio ${repos[$i]}"						
						echo "#########################################################"
						git status						
						echo "#########################################################"							

						let contador++						
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
						notify-send "Voce precisa comitar, ${repos[$i]}!"

						let contador++
					fi														
			  	fi				
				
				# add  
			  	let repo_founds++		

			  	commits=$(echo "Commits $repo_founds")

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
		notify-send "Nada para comitar, por enquanto! :)"
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
	check_git

	# [[ $@ == "check" ]] && check_git && exit 0
}

main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## verificar menu
# status_git	
# [[ $@ == "" ]] && status_git && exit 0 ||
# [[ $@ == "check" ]] && check_git && exit 0 || \
# # [[ $@ == "push" ]] && push_auto && exit 0 || \
# echo "nao entendi" && exit 1

### entrando no diretorio que precisa fazer commit
#
# busca_cam=$(git status | grep "modified:" | sed -e "s;"modified:";;g")
# converte_cam=$(echo $busca_cam | sed -e "s;    ;;g")
# # echo $converte_cam | sed -e "s;.sh;;g"
# # ls -f $local${repos[$i]}/$converte_cam 
# # echo $local${repos[$i]}
# # echo $converte_cam
# ls $local${repos[$i]}/$converte_cam | sed 's/\,.*\| -.*//'
# # find $local${repos[$i]}/ -type f -iname $converte_cam
# exit 1
# # for i in `cat lista.txt` ; do 
# # 	find /local/origem -type f -iname $i -exec cp --parents {} /local/destino \; ; 
# # done