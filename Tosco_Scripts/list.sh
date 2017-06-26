#!/bin/bash
# script para teste do comando shift e manipulacao de itens numa lista
#14/05/2015 

clear

if [ $1 ]
then
	clear
	echo "Voce digitou $# parametros;"
	echo "Sao eles: $@"
	echo "Vamos agora usar o comando SHIFT para remover o primeiro item da lista..."
	echo "Aguarde..."
	shift
	echo "Sua lista agora possui $# parametros"
	echo "Sao eles: $@"
else
	echo "Voce nao digitou nenhum parametro :("
fi
