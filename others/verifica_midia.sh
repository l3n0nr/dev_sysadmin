#!/usr/bin/env bash
#
####################
# DESENVOLVIDO POR #
####################
#
# por l3n0nr(Lenon Ricardo) 
# 	contato: <l3n0nrmsouza@gmail.com>
#
#################################################################################
#										                                        #
#	If I have seen further it is by standing on the shoulders of Giants.	    #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)		        #
#							~Isaac Newton		                                #
#										                                        #
#################################################################################
#
###################################################
# versão do script:              0.0.82.0.0.0     #
# # ultima ediçao realizada:      [21/09/20]      #
###################################################
#
# legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1];
# 	b = erros na execução;	
# 	c = interações com o script + versões funcionando;
# 	d = correções necessárias;
# 	e = pendencias
# 	f = desenvolver
#           - Definir variaveis globais como padrao, modificar apenas o caminho final nas variaveis locais dentro de cada função.
#
#       OBS: 
#           - Criar os arquivos necessarios, antes de realizar o backup na primeira vez que o script for executado.           
#
################################################################################
#
# Script testado em Linux
#	- Debian 10
#
################################################################################
#
################################################################################
# FUNCOES
#   -Realiza backup no formato de arquivos de texto de diversos diretórios para o MEGA.
#
################################################################################

## VARIAVEIS
# verificacao
var_tree=$(which tree)
local_destino="/home/l3n0nr/MEGA/"

# FILMES
caminhofilmes_origem="/media/l3n0nr/BACKUP/Arquivos/Filmes"
caminhofilmes_destino="/home/l3n0nr/MEGA/Outros/Lista/Filmes.txt"
caminhofilmes_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes.txt"    

	# assistidos
	caminhofilmes_a_origem="/media/l3n0nr/BACKUP/Arquivos/Filmes"  
	caminhofilmes_a_destino="/home/l3n0nr/MEGA/Outros/Lista/Filmes_Assistidos.txt"
	caminhofilmes_a_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes_Assistidos.txt"    

	# pendentes
	caminhofilmes_p_origem="/home/l3n0nr/Downloads/Torrents/Finalized/Movies"    
	caminhofilmes_p_destino="/home/l3n0nr/MEGA/Outros/Lista/Filmes_Pendentes.txt"
	caminhofilmes_p_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes_Pendentes.txt"    

# SERIADOS
caminhoseriados_origem="/media/l3n0nr/BACKUP/Arquivos/Seriados"    
caminhoseriados_destino="/home/l3n0nr/MEGA/Outros/Lista/Seriados.txt"    
caminhoseriados_destinohd="/media/l3n0nr/BACKUP/Arquivos/Seriados/Seriados.txt"

install_tree()
{	
    if [[ ! -e $var_tree ]]; then
        printf "O Tree nao foi encontrado, instalar por favor!"
    fi
}

filmes()
{       
    printf "[*] Verificando Filmes, aguarde...\n"

    tree $caminhofilmes_origem > $caminhofilmes_destino

    cat $caminhofilmes_destino > $caminhofilmes_destinohd
}

filmes_assistidos()
{    
    printf "[*] Verificando Filmes Assistidos, aguarde...\n"
    
    tree $caminhofilmes_a_origem | grep "[*]" | sort > $caminhofilmes_a_destino

    fa=`cat $caminhofilmes_a_destino | wc -l`

	printf "\n Este arquivo contem $fa filmes listados!" >> $caminhofilmes_a_destino
    
    cat $caminhofilmes_a_destino > $caminhofilmes_a_destinohd
}

filmes_pendentes()
{     
    printf "[*] Verificando Filmes Pendentes, aguarde...\n"
    
    tree $caminhofilmes_p_origem | grep "[+]" | sort > $caminhofilmes_p_destino
    
    fp=`cat $caminhofilmes_p_destino | wc -l`

	printf "\n Este arquivo contem $fp filmes pendentes!" >> $caminhofilmes_p_destino

    cat $caminhofilmes_a_destino > $caminhofilmes_a_destinohd    
}

seriados()
{   
    printf "[*] Verificando Seriados, aguarde...\n"

    tree $caminhoseriados_origem > $caminhoseriados_destino
    
    cat $caminhoseriados_destino > $caminhoseriados_destinohd
}

################################################################################
#
main()
{
	clear 

	if [ -e "$local_destino" ]; then 
	    printf "[+] Executando leitura das pastas \n"
	    printf "################################################### \n"
	    install_tree

	    if [[ ! -e $var_tree ]]; then
	        echo "[-] Tree não está instalado"
	    else
	        # filmes
	        filmes_assistidos
	        filmes_pendentes
	        seriados
	    fi
	    printf "################################################### \n"
	else 
	    printf "[-] Pasta '$local_destino' nao encontrada! \n"
	    printf "[-] Backup nao realizado!!\n"
	fi
}

main