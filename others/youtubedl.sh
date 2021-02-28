#!/usr/bin/env zsh
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#   FONTES DE PESQUISA  #
# # # # # # # # # # # # #
#
# Slackjeff 
# 	Source: <https://notabug.org/jeffersonrocha/youtube2mp3>
#
# Github - youtube-dl
#	Source: <https://github.com/rg3/youtube-dl/>
#
# Fabio Reis - Zenity – Exibindo caixas de diálogo com scripts do Shell no Linux
#	Source: <http://www.bosontreinamentos.com.br/shell-script/zenity-exibindo-caixas-de-dialogo-com-scripts-do-shell-no-linux/>
#
# How do I prompt users with a GUI dialog box to choose file/directory path, via the command-line?
#	Source: <https://askubuntu.com/questions/488350/how-do-i-prompt-users-with-a-gui-dialog-box-to-choose-file-directory-path-via-t>
#
# How to set up default download location in youtube-dl
# 	Source: <https://stackoverflow.com/questions/32482230/how-to-set-up-default-download-location-in-youtube-dl>
#
# A complete zenity dialog examples 2
#	Source: <http://linux.byexamples.com/archives/265/a-complete-zenity-dialog-examples-2/>
#
# How to select video quality from youtube-dl
#	Source: <https://askubuntu.com/questions/486297/how-to-select-video-quality-from-youtube-dl>
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por l3n0nr(Lenon Ricardo)
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
# # data de criação do script:    [14/06/18]      #             
# # ultima ediçao realizada:      [28/02/21]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;
# 	c = interações com o script;
# 	d = correções necessárias; 
# 	e = pendencias
# 	f = desenvolver
#
# variaveis do script
	# versao do script
	versao="0.2.11.0.0.0"  

	# formato do audio
	format=mp3					# default

	# variaveis	
	quality_a="320k"			# default

	# iniciando variaveis de verificacao
	local="0"
	option_m="0"	

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CORPO DO SCRIPT                               	  #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## status
f_verifica()
{
	if [[ $? == 1 ]]; then
		zenity --notification --text "Script finalizado!"  
		exit 1
	fi
}

## varios arquivos
f_vetor()
{	
	local=$(zenity --file-selection \
				   --directory \
				   --title="Selecione o local para salvar") ; f_verifica   	
}

## introducao no arquivo, quando vazio
f_intro()
{
	echo "# Cole os links, um abaixo do outro..." > $local/list.txt
	echo "# Salve(Ctrl+s) e apenas feche." >> $local/list.txt
	echo >> $local/list.txt

	mousepad $local/list.txt
}

f_vetor_audio()
{	
	if [[ -s $local/list.txt ]]; then
		f_intro
	fi

	youtube-dl --embed-thumbnail \
			   --continue \
			   --audio-quality "$quality_a" \
			   --extract-audio \
			   --audio-format "$format" -o "$local/%(title)s.%(ext)s" -a $local/list.txt
}

f_quality_video()
{
	video_quality=$(zenity --list --title="Qualidade do video" \
        	   --text="Qualidade"  \
        	   --column="Marque" --column="Modo" \
        	   --radiolist \
        	   FALSE 720 \
        	   TRUE 480 \
        	   FALSE 144 \
        	   FALSE 000 \
    )   

    if [[ $video_quality == '720' ]]; then
    	quality_video="-f 22"
    elif [[ $video_quality == '480' ]]; then
    	quality_video="-f 18"
    elif [[ $video_quality == '144' ]]; then    	
    	quality_video="-f 36"    
    elif [[ $video_quality == '000' ]]; then    	
    	quality_video=""    
    else
    	exit 1
	fi	

	f_verifica
}

f_vetor_video()
{	
	f_quality_video
	
	if [[ ! -s $local/list.txt ]]; then
		f_intro
	fi	

	youtube-dl $quality_video -o "$local/%(title)s.%(ext)s" -a $local/list.txt 
	f_verifica    	
}

main()
{
	# limpando a tela
	clear 

	option_m=$(zenity  --list  \
				--text "Midia Type.." \
				--radiolist \
				--column "Check" \
				--column "Format" \
							TRUE Video \
							FALSE Audio
	) ; f_verifica
	
	f_vetor
	if [[ $option_m == "Audio" ]]; then    		
		f_vetor_audio
	else			
		f_vetor_video  			
    fi

    f_verifica 
	
	if [[ $? == 0 ]]; then
		zenity --notification --text "Download finalizado!" 
		rm $local/list.txt	
	fi
}

## chamando funcao principal
main

#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           RODAPE DO SCRIPT                                  #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #