#!/bin/bash
#uso da environment variable RANDOM, que retorna um valor aleatorio entre 0 e 32767
#15/05/2015 

clear

echo "Sorteio da Sorte"

declare sorte=$RANDOM
declare -i tentativa=0

while [ $sorte -ne 0 ]
do
	sorte=$RANDOM
	tentativa=`expr $tentativa + 1`
	echo $RANDOM >> azar.out

	clear
	echo $tentativa
done

echo "Seu numero da sorte e: $sorte"
echo "Voce usou $tentativa tentativas"
