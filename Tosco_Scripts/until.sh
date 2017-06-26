#!/bin/bash
#Script para test de looping
# 09/05/2015 

clear
VALOR=1
until [ $VALOR -eq 0 ]
do
	clear
	echo -n "Digite um valor diferente de zero: "
	read VALOR
done
clear
echo "Voce digitou o numero $VALOR ."
