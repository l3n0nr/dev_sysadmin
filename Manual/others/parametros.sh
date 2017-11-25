#!/bin/bash
#
# CABEÇALHO
# Referencia: <https://youtu.be/AZdGMIm3WAU>
#
#
# CORPO DO SCRIPT
# nome do programa
echo "O nome do programa é: $0"

# quantos parametros foram passados
echo "A quantidade de parametros foram: $#"

# nomes de parametros
echo "O nomes de parametros sao: $*"

# nome dos parametros
echo "Os nomes de parametros sao: $@"

# imprimindo nome dos parametros com for
for i in "$@"; do
	echo "$i"
done
# 
# RODAPE