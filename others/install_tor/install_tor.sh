#!/usr/bin/env bash
#
######################################################################
#
# ULT_EDICAO: 11/03/20
# VERSAO: 0.52
# AUTOR: lenonr
#
######################################################################
#
# DESCRICAO: Baixa arquivo tor e extrai na pasta $caminho
#
######################################################################
#
# ERRO: Verificar permissao execucao arquivo /opt/tor
#
######################################################################
#
source variables.conf
#
# funcao verifica se arquivo existe
f_check_file()
{
	if [[ -e $check ]]; then
		printf "[-] Arquivo $check ja existe! Basta executa-lo..\n"
		exit 1
	fi
}

# funcao baixa arquivo
f_download_tor()
{	
	printf "[*] Baixando arquivo, aguarde.. \n"

	# baixando arquivo via WGET, com possibilidade de contianuacao
	wget -c $url_tor -O $apelido > /dev/null
}

# funcao verificao pasta destino
f_check_local()
{
	printf "[*] Verificando pasta... \n"

	# criando caminho caso nao exista
	mkdir -p $caminho > /dev/null
}

# funcao descompacta arquivo
f_uncomp_file()
{
	## enviando pasta extraida para $caminho
	printf "[*] Descompactando arquivo... \n"

	tar -xvJf $apelido -C $caminho > /dev/null
}

# funcao altera permissao
f_change_perm()
{
	printf "[*] Alterando permissoes dos arquivos... \n"

	# dando permissao total para modificar o arquivos na pasta
	chmod 755 -R $caminho

	# alterando permissao para que usuario comum(nao root), consiga utilizar o lancador!
	chown -R $user $check/Browser
}

# funcao verifica saida do ultimo comando
f_check_status()
{
	# verifica se ultimo comando nao foi igual a zero 
	[[ $? -ne 0 ]] && echo "[-] ERRO EM ${acoes[$i]}." && exit 1
}

## funcao - chama outras acima
f_tor()
{		
	# verifica se e igual a root,
	# se for diferente, fecha o script!!
	if [[ `id -u` -ne 0 ]]; then
		clear
		printf "[-] PRECISA DE ROOT PARA SER EXECUTADO!"
		exit 1
	fi

	# executando vetor de acoes
    for (( i = 0; i <= ${#acoes[@]}; i++ )); do             
        # executando acoes
        ${acoes[$i]} 

        # verificando se existiu algum erro na execucao - se sim, sai do loop
		f_check_status        
    done
}

## funcao - checa url
f_check_url()
{
	echo $url_tor
}

# chamando funcao principal
main()
{
	# limpando a tela na inicializacao do script
	clear

	if [[ -z $1 ]]; then
		echo "Voce precisa utilizar um dos seguintes parametros:"
		echo "~" $0 "link ~"
		echo "~" $0 "verifica ~"
		echo "~" $0 "instala ~"		
	elif [[ $1 == "verifica" ]]; then
		f_check_file
	elif [[ $1 == "instala" ]]; then
		f_tor
	elif [[ $1 == "link" ]]; then
		echo "Arquivo que sera baixado:"
		f_check_url
	fi
}

# chamando script 
main $1

