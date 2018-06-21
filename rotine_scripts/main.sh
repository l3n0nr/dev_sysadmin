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
## DESCRICAO: Executa scripts na inicializacao do sistema
#
# versao do script
    versao="0.0.10.0.0"             
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
main()
{	
	## locais dos scripts
	v_git="arquivos_git/pull_git.sh"
	v_zsh="../others/backup_zsh.sh"
	v_dropbox="../others/dropbox.sh"

	## chamando funcoes 	
	funcoes=("$v_zsh restaura" $v_dropbox $v_git)	# "$v_zsh restaura" = gambiarra bonita... Eu sei! :_)	

	for (( i = 0; i <= ${#funcoes[@]}; i++ )); do  		
		# chamando funcao
		${funcoes[$i]}

		# se houver erro na execucao do script
		# mostra mensagem para o usuario
		if [[ ! $? -eq 0 ]]; then
			zenity --notification \
				   --text "Erro na funcao ${funcoes[$i]}"
		fi
	done	
}

## chamando funcao
main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #