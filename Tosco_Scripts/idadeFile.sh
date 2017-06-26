#!/bin/bash
#verifica qual arquivo eh mais novo
#11/05/2015 

clear

declare A B

echo -n "Digite o nome do primeiro arquivo: "
read A
echo -n "Digite o nome do segundo arquivo: "
read B

if [ $A -nt $B ]
then
	echo "O arquivo $A e mais novo que o $B"
else
	echo "O arquivo $B e mais novo que o $A"
fi
