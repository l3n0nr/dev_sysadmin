#!/bin/bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#									      									  #
#	If I have seen further it is by standing on the shoulders of Giants.      #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)	          #
#							~Isaac Newton	      							  #
#									      									  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [20/06/18]      #             
# # ultima ediçao realizada:      [20/06/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
## DESCRICAO: Verifica se existe repositorio do github, com push pendente.
#
# versao do script
    versao="0.0.15.0.0"             
#    
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;
# 	c = interações com o script;
# 	d = correções necessárias; 
# 	e = pendencias
# 	f = desenvolver
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## funcao principal
local='/home/lenonr/Github/'		# pasta do repositorio

# repositorios disponiveis
repos=(dev_xfce dev_scripts dev_ksp dev_sysadmin dev_web dev_clonerepo dev_docker)		# repositorios

## chamando funcao
check_git()
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
					git status | grep "to publish your local commits" > /dev/null
  											
					# if value = 0, then comparation is true
					if [[ $? == "0" ]]; then
						zenity --notification \
							   --text "Ei $USER, voce precisa dar push em ${repos[$i]}!"
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

main()
{	
	check_git	
}

## chamando funcao
main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #