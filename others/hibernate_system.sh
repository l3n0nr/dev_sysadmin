#!/usr/bin env bash
#
# Descricao: Hibernando sistema, via linha de comando.
#
#
f_hibernate()
{
	notify-send "Hibernando sistema...."

	sleep 3

	# hibernate system
	systemctl hibernate
}

main()
{
	f_hibernate
}

# chamando funcao
main