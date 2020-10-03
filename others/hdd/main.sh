#!/usr/bin/env bash
#
####################
# DESENVOLVIDO POR #
####################
#
# por l3n0nr(Lenon Ricardo) 
# 	contato: <lenonrmsouza@gmail.com>
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
# versão do script:              0.0.85.0.0.0     #
# # ultima ediçao realizada:      [03/10/20]      #
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
local_destino="$HOME/MEGA/"
hdd="/media/l3n0nr/BACKUP"
local_hdd='$hdd/Arquivos/Filmes'

# FILMES
caminhofilmes_origem="/media/l3n0nr/BACKUP/Arquivos/Filmes"
caminhofilmes_destino="$HOME/MEGA/Outros/Lista/Filmes.txt"
caminhofilmes_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes.txt"    

	# assistidos
	caminhofilmes_a_origem="/media/l3n0nr/BACKUP/Arquivos/Filmes"  
	caminhofilmes_a_destino="$HOME/MEGA/Outros/Lista/Filmes_Assistidos.txt"
	caminhofilmes_a_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes_Assistidos.txt"    

	# pendentes
	caminhofilmes_p_origem="$HOME/Downloads/Torrents/Finalized/Movies"    
	caminhofilmes_p_destino="$HOME/MEGA/Outros/Lista/Filmes_Pendentes.txt"
	caminhofilmes_p_destinohd="/media/l3n0nr/BACKUP/Arquivos/Filmes/Filmes_Pendentes.txt"    

# SERIADOS
caminhoseriados_origem="/media/l3n0nr/BACKUP/Arquivos/Seriados"    
caminhoseriados_destino="$HOME/MEGA/Outros/Lista/Seriados.txt"    
caminhoseriados_destinohd="/media/l3n0nr/BACKUP/Arquivos/Seriados/Seriados.txt"

install_tree()
{	
    if [[ ! -e $var_tree ]]; then
        printf "O Tree nao foi encontrado, instalar por favor!"
        exit 1
    fi
}

filmes()
{      
	# check_files
	if [[ ! -e $caminhofilmes_origem ]]; then
		mkdir -p "${caminhofilmes_origem%/*}" && touch "$caminhofilmes_origem"
	fi

	if [[ ! -e $caminhofilmes_destino ]]; then
		mkdir -p "${caminhofilmes_destino%/*}" && touch "$caminhofilmes_destino"	
	fi

	if [[ ! -e $caminhofilmes_destinohd ]]; then
		mkdir -p "${caminhofilmes_destinohd%/*}" && touch "$caminhofilmes_destinohd"	
	fi

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
	# check_files
	if [[ ! -e $caminhofilmes_p_origem ]]; then
		mkdir -p "${caminhofilmes_p_origem%/*}" && touch "$caminhofilmes_p_origem"
	fi

	if [[ ! -e $caminhofilmes_p_destino ]]; then
		mkdir -p "${caminhofilmes_p_destino%/*}" && touch "$caminhofilmes_p_destino"
	fi

	if [[ ! -e $caminhofilmes_p_destinohd ]]; then
		mkdir -p "${caminhofilmes_p_destinohd%/*}" && touch "$caminhofilmes_p_destinohd"
	fi

    printf "[*] Verificando Filmes Pendentes, aguarde...\n"
    
    tree $caminhofilmes_p_origem | grep "[+]" | sort > $caminhofilmes_p_destino
    
    fp=`cat $caminhofilmes_p_destino | wc -l`

	printf "\n Este arquivo contem $fp filmes pendentes!" >> $caminhofilmes_p_destino

    cat $caminhofilmes_a_destino > $caminhofilmes_a_destinohd    
}

seriados()
{   
	# check_files
	if [[ ! -e $caminhoseriados_origem ]]; then
		mkdir -p "${caminhoseriados_origem%/*}" && touch "$caminhoseriados_origem"
	fi

	if [[ ! -e $caminhoseriados_destino ]]; then
		mkdir -p "${caminhoseriados_destino%/*}" && touch "$caminhoseriados_destino"
	fi

	if [[ ! -e $caminhoseriados_destinohd ]]; then
		mkdir -p "${caminhoseriados_destinohd%/*}" && touch "$caminhoseriados_destinohd"
	fi

    printf "[*] Verificando Seriados, aguarde...\n"

    tree $caminhoseriados_origem > $caminhoseriados_destino
    
    cat $caminhoseriados_destino > $caminhoseriados_destinohd
}

list_files()
{
	printf "Movies:" && cat $caminhofilmes_a_destino | tail -1
}

################################################################################
#
main()
{
	clear 

	## check hdd | CONNECTED
	if [ -e "$local_hdd" ]; then 
	    if [ -e "$local_destino" ]; then 
	    	if [[ $1 == "list" ]]; then
	    		list_files
	    	elif [[ $1 == "check" ]]; then
	    		install_tree

		    	printf "[+] Executando leitura das pastas \n"
	    		printf "################################################### \n"
	    		# filmes
		        filmes_assistidos
		        filmes_pendentes
		        seriados
		    	printf "################################################### \n"
	    	else    		
		    	echo "Please call, one parameter: list | check"
	    	fi
		else 
		    printf "[-] Pasta '$local_destino' nao encontrada! \n"
		    printf "[-] Backup nao realizado!!\n"
		fi
  	else
		echo "Conecte o $hdd ao computador!"
	fi	
}

main $1