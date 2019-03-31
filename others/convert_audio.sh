#!/usr/bin/env bash
#
########################################################
#
## DESCRICAO
# 	Converte audio para pasta especifica
#
## DATA_CRIACAO: 31/03/19
## ULTIMA_MODIF: 31/03/19
## VERSAO: 0.10
#
## REFERENCIAS
# 	https://ubuntuforums.org/showthread.php?t=1614765
# 	https://stackoverflow.com/questions/20512865/batch-if-file-with-filename-exist
#
########################################################
#
check_file()
{
	log="/tmp/convert_audio.txt"

	if [[ -e $log ]]; then
		touch $log
	fi
}

convert()
{
	caminho="/home/lenonr/Música/Podcast"

	cd $caminho

	for f in *.m4a; do 
		if [[ "${f%.m4a}" ]]; then
			echo "Executando conversão..."
			ffmpeg -i "$f" -codec:v copy -codec:a libmp3lame -q:a 2 $caminho/"${f%.m4a}.mp3"; 

			if [[ $? == "1" ]]; then
	    		echo "$(date) - NADA ACONTECEU" >> $log
	    		exit 1
	    	else
	    		echo "$(date) - SUCESSO - $f" >> $log
	    		rm "${f%}"
	    	fi
		fi
	done
}

main()
{
	clear

	check_file
	convert
}

## chama funcao principal
main