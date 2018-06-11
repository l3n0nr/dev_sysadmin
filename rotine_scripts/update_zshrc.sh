#!/bin/bash
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [04/04/18]      #
# # ultima ediçao realizada:      [04/04/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
# local user folder
pasta_home="/home/lenonr/"          

# local folder github
local_git="/home/lenonr/Github/dev_xfce/Auto_Config/base"

# printf "\n\nArquivo update_zshrc.sh executado" >> /tmp/main.txt

if [ -e "$local_git" ]; then	
	cat $local_git/.zshrc > $pasta_home/.zshrc 
else
	echo "ERROR - update_zshrc" >> /tmp/main.txt
fi