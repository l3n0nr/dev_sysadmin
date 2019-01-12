#!/usr/bin/env bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   FONTES DE PESQUISA  #
# # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# Referencia: <https://www.vivaolinux.com.br/script/Verificar-eou-limpar-cache-de-memoria>
#   Autor: Pedro - Viva o Linux
# 
# Referencia: <http://www.hardware.com.br/guias/programando-shell-script/variaveis-comparacao.html>
#   Autor: Carlos E. Morimoto - Guia do Hardware
#
# Referencia: <https://elias.praciano.com/2016/03/perguntas-e-respostas-sobre-o-swap/>
#	Autor: Limpando swap com script otimizado
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
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
# # versão do script:           [0.1.102.0.0.0]    #
# # data de criação do script:    [03/11/17]      #
# # ultima ediçao realizada:      [11/01/19]      #
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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#   [+] - Açao realizada; 
#   [*] - Processamento;
#   [-] - Não executado;
#   [!] - Mensagem de aviso;
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # Script testado em
#	- Xubuntu 16.04
#   - Debian 9
#
# # Compativel com
#   - Debian Stable
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# DESCRICAO
#	Reinicia a memoria swap de acordo com a quantidade de memoria RAM disponivel.
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                               CORPO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
clear

export DISPLAY=":0.0"
local="/tmp/clear_memory.txt"

# realizando verificação de sudo
if [[ `id -u` -ne 0 ]]; then       
    printf "############################################################################ \n"
    printf "[!] O script para funcionar, precisa estar sendo executado como root! \n"
    printf "[!] Favor, logar na conta root e executar o script novamente. \n"
    printf "############################################################################ \n"    
    exit 1
fi

limpa()
{
	swapoff -a && swapon -a && printf "SUCESS - " >> $local && date >> $local
}

porcentagem()
{
	# minimo de memoria RAM extra para ser realizada a limpeza(porcentagem)
	porcentagem_mem="45"

	# variaveis de verificacao da memoria RAM
	memoria_total=$(free | awk '/Mem:/ {print $2}')	
	memoria_taxa=$(($porcentagem_mem * ($memoria_total / 100)))
	memoria_livre=$(free | awk '/Mem:/ {print $4}')

	# verificando a memoria SWAP
	swap=$(LC_ALL=C free | awk '/Swap:/ {print $3}')
						
	# realizando teste
	if [[ $memoria_livre > $memoria_taxa ]]; then
		notify-send -t 10000 "Reiniciando a SWAP!"
		limpa
	else
		printf "FAILED - " >> $local && date >> $local
	fi
}

main()
{
	porcentagem
}

# # executando script
main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
