#!/bin/bash
#testando o IF, agora com opcoes do tipo b = block, c = character and so on
#11/05/2015 

clear

declare ARQ

echo -n "Digite o file name: "
read ARQ

if [ -b $ARQ ]
then
	echo "O $ARQ e um dispositivo de blocos"
else
	echo "O $ARQ nao e um dispositivo de blocos"
fi
