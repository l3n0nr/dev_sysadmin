#!/usr/bin/env bash
#
######################
## CABECALHO DO SCRIPT
######################
## DESCRICAO
#	Interface grafica para gravar ISO em um CD, via interface zenity.
#
## AUTOR
#	lenonr(lenonrmsouza@gmail.com)
#
## REFERENCIA
# 
## por Slackjeff
# 	<https://notabug.org/jeffersonrocha/ddp/src/master/ddp>
#
######################
## CORPO DO SCRIPT
######################
#
#
## Teste inicial
#####################################
if [[ `id -u` -ne 0 ]]; then
	clear 
	echo "PRECISA SER ROOT PARA CONTINUAR" 
	exit 1
fi
#####################################
#
f_verifica()
{
	[[ $? == "1" ]] && \
		zenity --notification \
			   --text "Script finalizado, antes do esperado!" && exit 1
}

f_grava()
{
	l_grava=$(zenity --file-selection \
				   --directory \
				   --title="Selecione o local para gravar") ; f_verifica   		
}

f_iso()
{
	l_iso=$(zenity --file-selection \
				   --title="Selecione a ISO") ; f_verifica   	
}

f_caminhos()
{
	echo $l_grava
	echo $l_iso

	## executar comando dd - ATENCAO AO FAZER ISSO!!
}

#
main()
{
	f_grava
	f_iso
	f_caminhos
}
#
## chamando funcao principal
main
#
######################
## RODAPE DO SCRIPT
######################