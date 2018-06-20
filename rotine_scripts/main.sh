#!/bin/bash
#
## Descricao: Executa scripts na inicializacao do sistema

## chamando scripts externos
source arquivos_git/pull_git.sh	## verifica git
source update_zshrc.sh			## atualiza ZSH
source ../others/dropbox.sh		## reinicia dropbox	

## funcao principal
main()
{
	funcoes=(update_zshrc f_dropbox pull_git)

	for (( i = 0; i <= ${#funcoes[@]}; i++ )); do  
		# chamando funcao
		${funcoes[$i]}

		# se houver erro na execucao do script
		# mostra mensagem para o usuario
		if [[ ! $? -eq 0 ]]; then
			zenity --info --text "Erro na funcao ${funcoes[$i]}"
		fi
	done	
}

## chamando funcao
main