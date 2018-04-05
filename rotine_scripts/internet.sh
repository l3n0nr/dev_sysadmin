#!/bin/zsh
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [28/03/18]      #
# # ultima ediçao realizada:      [04/04/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#
# variaveis de ambiente
servidor="google.com"						# servidor para teste
# tempo=300s									# tempo de intervalo do teste(segundos) - 5 minutos
# tempo_DATE="300 seconds"

# realiza teste enquanto valor de internet for "0"(falso)	
func_internet()
{
	# intervalo de tempo 
	# while true; do	
		# ====================================== #
		# testando conexao internet
		# ====================================== #	
		ping -q -c5 $servidor > /dev/null
		# ping -q -c1 $servidor >> /tmp/internet.txt

		# verificando valor
		# if [[ $? = "0" ]]; then	
		if [ $? = "0" ]; then	
			mensagem="Internet funcionando!"
			echo $mensagem >> /tmp/internet.txt
			date >> /tmp/internet.txt
			printf "\n" >> /tmp/internet.txt

			# notify-send -u normal "$mensagem" -t 2500
		else				
			mensagem="Sem conexao ao link $servidor!"
			date >> /tmp/internet.txt
			echo $mensagem >> /tmp/internet.txt

			notify-send -u normal "$mensagem" -t 5000		
		fi	

		# mostrando proxima verificacao
		# echo "Proxima verificação em:" >> /tmp/internet.txt
		# date -d "$tempo_DATE" >> /tmp/internet.txt

		# aguardando tempo especifico
		# sleep $tempo
	# done
}

echo "Inicio do script" > /tmp/internet.txt
date >> /tmp/internet.txt
printf "\n" >> /tmp/internet.txt

# enviando saida para main.txt
# printf "\n\nArquivo internet.sh executado" >> /tmp/main.txt

# chamando funcao
func_internet

date >> /tmp/internet.txt
