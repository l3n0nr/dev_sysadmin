#!/bin/bash

printf "\n\nArquivo update_zshrc.sh executado" >> /tmp/main.txt

# local user folder
pasta_home="/home/lenonr/"          

# local folder github
local_git="/home/lenonr/Github/dev_xfce/Auto_Config/base"

if [ -e "$local_git" ]; then	
	cat $local_git/.zshrc > $pasta_home/.zshrc >> /tmp/main.txt
else
	echo "ERROR - update_zshrc" >> /tmp/main.txt
fi