#!/bin/bash
# test while
#09/05/2015 
clear

#Declare -l -> converte caracteres para Lower-case, -u -> Upper-case
declare -l RESP=y
#Declare -i -> variavel so aceita valores INT
declare -i COUNT=a

while [ $RESP == y ]
do
clear
	cat ../apaulaaf
	echo 
	echo -n "Voce quer ver novamente? [ y | n ] "
	read RESP
	COUNT=`expr $COUNT + 1`
done
clear
echo "Voce decidiu nao exibir o texto."
echo "Voce viu o texto $COUNT vezes."
