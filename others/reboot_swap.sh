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
# # versão do script:           [0.1.90.0.0.0]    #
# # data de criação do script:    [03/11/17]      #
# # ultima ediçao realizada:      [26/12/18]      #
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
#   - Debian 9 Stable
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# DESCRICAO
#	Reinicia a memoria swap de acordo com a quantidade de memoria RAM disponivel.
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                               CORPO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 

# limpando tela
clear

local="/tmp/clear_memory.txt"

# realizando verificação de sudo
if [[ `id -u` -ne 0 ]]; then
    clear        
    printf "############################################################################ \n"
    printf "[!] O script para funcionar, precisa estar sendo executado como root! \n"
    printf "[!] Favor, logar na conta root e executar o script novamente. \n"
    printf "############################################################################ \n"    
    exit 1
fi

verifica()
{
	## taxa de segurança em "%" de memoria extra(por swap), evitando travamentos da maquina
	## valores menores ja travaram!
	# TAXA=50 
	TAXA=30 

	# # # MEMORIA
	MEM_LIVRE=$(awk '/^MemFree/ { print $2; }' /proc/meminfo)

	# # # SWAP 
	## Kb
	SWAP_TOTAL=$(awk '/^SwapTotal/ { print $2; }' /proc/meminfo)
	## MB
	SWAP_TOTAL_MB=$(($SWAP_TOTAL / 1024))

	## Kb
	SWAP_LIVRE=$(awk '/^SwapFree/ { print $2; }' /proc/meminfo)
	## MB
	SWAP_LIVRE_MB=$(($SWAP_LIVRE / 1024))

	# calculo de espaço disponivel
	SWAP_USADA=$(($SWAP_TOTAL - $SWAP_LIVRE))

	# aplicando margem de segurança
	SWAP_USADA=$(((($SWAP_USADA * $TAXA)/100) + $SWAP_USADA))

	# realizando calculo para MB
	MEM_LIVRE_MB=$(($MEM_LIVRE / 1024))
	SWAP_USADA_MB=$(($SWAP_USADA / 1024)) 

    # if [[ $SWAP_USADA_MB -gt $MEM_LIVRE_MB ]]; then
    if [[ $MEM_LIVRE_MB < $SWAP_USADA_MB ]]; then
        # printf "[!] Memória SWAP, será reiniciada pois a memoria a ser restaurada $SWAP_USADA_MB MB, é menor do que a disponivel $MEM_LIVRE_MB MB! \n"
        printf "[+] Memória SWAP desligada! \n"
        printf "[*] Limpando a memória Swap, aguarde.. \n"
        swapoff -a && swapon -a
        printf "[*] Memória SWAP ligada novamente! \n"        
        printf "[+] Limpeza na memória SWAP realizada com sucesso! \n"
        printf "SUCESS - " >> $local && date >> $local
    else        
        printf "[!] Não foi possivel reiniciar a SWAP, pois a memoria a ser restaurada $SWAP_USADA_MB MB, é maior do que a disponivel $MEM_LIVRE_MB MB! \n"
       	printf "FAILED - " >> $local && date >> $local        
    fi
} 

verifica_otimizado()
{
	# # mem=$(LC_ALL=C free  | awk '/Mem:/ {print $4}')
	# mem=$(free  | awk '/Mem:/ {print $4}')
	# # swap=$(LC_ALL=C free | awk '/Swap:/ {print $3}')
	# swap=$(free | awk '/Swap:/ {print $3}')

	# if [[ $mem > $swap ]]; then
	# # # if [ $mem > $swap ]; then
	# 	# printf "[!] Não foi possivel reiniciar a SWAP, pois a memoria a ser restaurada $swap, é maior do que a disponivel $mem! \n" >&2
	# 	printf "[!] Não foi possivel reiniciar a SWAP \n" && printf "FAILED - " >> $local && date >> $local
	# 	exit 1
	# else
	# 	# printf "[!] Memória SWAP, será reiniciada! \n"
	#  #    printf "[+] Memória SWAP desligada! \n"    
	#  #    printf "[*] Limpando a memória Swap, aguarde.. \n"
	#     swapoff -a && swapon -a && printf "SUCESS - " >> $local && date >> $local
	#     # printf "[*] Memória SWAP ligada novamente! \n"        
	#     # printf "[+] Limpeza na memória SWAP realizada com sucesso! \n"	    
	# fi

	swapoff -a && swapon -a && printf "SUCESS - " >> $local && date >> $local \
			   || printf "FAILED - " >> $local && date >> $local		
}

porcentagem()
{
	# minimo de memoria RAM para ser considerado
	porcentagem_mem="30"
	# porcentagem_mem="10"

	# variaveis de verificacao da memoria RAM
	memoria_total=$(free | awk '/Mem:/ {print $2}')	
	memoria_taxa=$(($porcentagem_mem * ($memoria_total / 100)))
	memoria_livre=$(free | awk '/Mem:/ {print $4}')

	# verificando a memoria SWAP
	swap=$(LC_ALL=C free | awk '/Swap:/ {print $3}')
						
	# echo $memoria_taxa
	# echo $memoria_livre

	# realizando teste
	# if [[ $memoria_livre < $memoria_taxa && $swap != "0" ]]; then
	if [[ $memoria_livre > $memoria_taxa ]]; then		
		verifica_otimizado
		# verifica
	fi
	# else
	# 	# echo "Memoria disponivel:" $(($memoria_livre/1024)) "MB"
	# 	# echo "Porcentagem(menor ou igual a):" $(($memoria_taxa/1024)) "MB"
	# 	printf "FAILED - " >> $local && date >> $local		
	# fi
}

main()
{
	# porcentagem
	verifica_otimizado
}

# # executando script
main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
