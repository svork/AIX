#!/bin/bash
#test de parametros com o $@ e o $*, usando um for
#12/05/2015 

clear

declare arg

if [ $1 ]
then
	for arg in $*
	do
		echo "The current parameter from \$* is: $arg"
	done

	for arg in "$@"
	do
		echo "O valor atual de \$@ is: $arg"
	done
else
	echo "Voce nao digitou nenhum parametro"
fi
