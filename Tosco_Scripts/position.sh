#!/bin/bash
#test do positional 
#12/05/2015 

clear

if [ $1 ]
then
	echo "Voce digitou $# parametros"
	echo "O nome do script: $0"
	echo "O primeiro parametro e: $1"
else
	echo "Voce nao digitou nenhum parametro"
fi
