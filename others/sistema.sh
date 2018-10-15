#!/usr/bin/env bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # # 
#
# por lenonr(Lenon Ricardo) 
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#	If I have seen further it is by standing on the shoulders of Giants.		#
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)				#
#							~Isaac Newton										#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:              [0.0.28]       #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [15/10/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # Script testado em
#	- Xubuntu 16.04
#       - Debian 9
#
# # Compativel com
#       - Ubuntu
#       - Debian 9
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# 
# # FUNCOES
# # # # # # # # # #    
# # DADOS DO SISTEMA
# 
install_system=$(ls -lct /etc | tail -1 | awk '{print $6, $7, $8}')
date_now=$(date +%x-%k%M)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#                               CORPO DO SCRIPT                               	#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# 
#
basic()
{
	# limpa a tela
	clear 

	echo "###############################################################################"

	# mostra informacoes sistema
	neofetch 

    # memoria utilizada
    free -hmt ; echo

	# lista uso do disco - raiz
	df -h / ; echo    

	# lista uso do disco - home
	df -h /home

	echo	
	echo "Sistema instalado em $install_system"
	echo "###############################################################################"
}

main()
{
	basic
}
    
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
main
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 